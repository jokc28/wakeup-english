import 'dart:convert';
import 'dart:io';

const _usage = '''
Usage:
  dart run tool/tatoeba_filter.dart \\
    --sentences /path/to/sentences.tsv \\
    --links /path/to/links.tsv \\
    --out build/tatoeba_review_candidates.json \\
    --limit 500

Expected files:
  sentences.tsv: sentence_id<TAB>language_code<TAB>text
  links.tsv: sentence_id<TAB>translated_sentence_id

This tool creates review candidates only. Do not bundle the output into the app
until each row is manually reviewed for quality, appropriateness, and attribution.
''';

void main(List<String> args) {
  final options = _parseArgs(args);
  if (options == null) {
    stderr.write(_usage);
    exitCode = 64;
    return;
  }

  final sentencesFile = File(options.sentencesPath);
  final linksFile = File(options.linksPath);
  if (!sentencesFile.existsSync()) {
    stderr.writeln('Missing sentences file: ${options.sentencesPath}');
    exitCode = 66;
    return;
  }
  if (!linksFile.existsSync()) {
    stderr.writeln('Missing links file: ${options.linksPath}');
    exitCode = 66;
    return;
  }

  final sentences = _loadSentences(sentencesFile);
  final candidates = _buildCandidates(
    linksFile: linksFile,
    sentences: sentences,
    limit: options.limit,
  );

  final outFile = File(options.outPath);
  outFile.parent.createSync(recursive: true);
  const encoder = JsonEncoder.withIndent('  ');
  outFile.writeAsStringSync('${encoder.convert(candidates)}\n');

  stdout.writeln('Wrote ${candidates.length} candidates to ${outFile.path}');
}

Map<int, _Sentence> _loadSentences(File file) {
  final result = <int, _Sentence>{};

  for (final line in file.readAsLinesSync()) {
    final parts = line.split('\t');
    if (parts.length < 3) continue;

    final id = int.tryParse(parts[0]);
    if (id == null) continue;

    final lang = parts[1].trim();
    if (lang != 'eng' && lang != 'kor') continue;

    final text = parts.sublist(2).join('\t').trim();
    if (text.isEmpty) continue;

    result[id] = _Sentence(id: id, lang: lang, text: text);
  }

  return result;
}

List<Map<String, Object>> _buildCandidates({
  required File linksFile,
  required Map<int, _Sentence> sentences,
  required int limit,
}) {
  final candidates = <Map<String, Object>>[];
  final seenEnglish = <String>{};

  for (final line in linksFile.readAsLinesSync()) {
    if (candidates.length >= limit) break;

    final parts = line.split('\t');
    if (parts.length < 2) continue;

    final leftId = int.tryParse(parts[0]);
    final rightId = int.tryParse(parts[1]);
    if (leftId == null || rightId == null) continue;

    final left = sentences[leftId];
    final right = sentences[rightId];
    if (left == null || right == null || left.lang == right.lang) continue;

    final english = left.lang == 'eng' ? left : right;
    final korean = left.lang == 'kor' ? left : right;

    if (!_isGoodEnglishCandidate(english.text)) continue;
    if (!_isGoodKoreanCandidate(korean.text)) continue;

    final key = english.text.toLowerCase();
    if (!seenEnglish.add(key)) continue;

    candidates.add({
      'source': 'tatoeba_sentence',
      'source_label': 'Tatoeba CC BY 2.0 FR',
      'source_url': 'https://tatoeba.org/en/sentences/show/${english.id}',
      'license': 'CC BY 2.0 FR',
      'review_status': 'needs_manual_review',
      'expression_en': english.text,
      'expression_meaning_kr': korean.text,
      'situation_kr': 'Tatoeba 영한 문장 후보. 앱 반영 전 상황 설명을 직접 작성해야 함.',
      'difficulty': _estimateDifficulty(english.text),
    });
  }

  return candidates;
}

bool _isGoodEnglishCandidate(String text) {
  if (text.length < 8 || text.length > 90) return false;
  if (!RegExp('[A-Za-z]').hasMatch(text)) return false;
  if (RegExp(r'https?://|www\.|@').hasMatch(text)) return false;
  if (RegExp(r'[\[\]{}<>]').hasMatch(text)) return false;
  if (text.split(RegExp(r'\s+')).length > 14) return false;
  if (RegExp(r'\b(Tom|Mary)\b').hasMatch(text)) return false;
  return true;
}

bool _isGoodKoreanCandidate(String text) {
  if (text.length < 3 || text.length > 90) return false;
  if (RegExp(r'https?://|www\.|@').hasMatch(text)) return false;
  return RegExp('[가-힣]').hasMatch(text);
}

String _estimateDifficulty(String text) {
  final wordCount = text.split(RegExp(r'\s+')).length;
  if (wordCount <= 5) return 'beginner';
  if (wordCount <= 9) return 'intermediate';
  return 'advanced';
}

_Options? _parseArgs(List<String> args) {
  String? sentencesPath;
  String? linksPath;
  var outPath = 'build/tatoeba_review_candidates.json';
  var limit = 500;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    String nextValue() {
      if (i + 1 >= args.length) {
        throw const FormatException('Missing argument value');
      }
      i++;
      return args[i];
    }

    switch (arg) {
      case '--sentences':
        sentencesPath = nextValue();
        break;
      case '--links':
        linksPath = nextValue();
        break;
      case '--out':
        outPath = nextValue();
        break;
      case '--limit':
        limit = int.parse(nextValue());
        break;
      case '--help':
      case '-h':
        return null;
      default:
        throw FormatException('Unknown option: $arg');
    }
  }

  if (sentencesPath == null || linksPath == null || limit < 1) return null;

  return _Options(
    sentencesPath: sentencesPath,
    linksPath: linksPath,
    outPath: outPath,
    limit: limit,
  );
}

class _Sentence {
  final int id;
  final String lang;
  final String text;

  const _Sentence({
    required this.id,
    required this.lang,
    required this.text,
  });
}

class _Options {
  final String sentencesPath;
  final String linksPath;
  final String outPath;
  final int limit;

  const _Options({
    required this.sentencesPath,
    required this.linksPath,
    required this.outPath,
    required this.limit,
  });
}
