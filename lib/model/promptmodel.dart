

class PromptModel {
  final List<Candidate>? candidates;

  PromptModel({this.candidates});

  factory PromptModel.fromJson(Map<String, dynamic> json) {
    List<Candidate> cands = [];
    if (json['candidates'] != null && json['candidates'] is List) {
      for (var v in (json['candidates'] as List)) {
        cands.add(Candidate.fromJson(v));
      }
    }
    return PromptModel(candidates: cands);
  }

  @override
  String toString() {
    return 'PromptModel(candidates: ${candidates?.map((e) => e.toString()).join(", ")})';
  }
}

class Candidate {
  final List<Part>? parts;
  // You can add other fields from the API response for 'candidate' if needed,
  // e.g., content, finishReason, index, safetyRatings

  Candidate({this.parts});

  factory Candidate.fromJson(Map<String, dynamic> json) {
    List<Part> p = [];
    if (json['parts'] != null && json['parts'] is List) {
      for (var v in (json['parts'] as List)) {
        p.add(Part.fromJson(v));
      }
    }
    return Candidate(parts: p);
  }

  @override
  String toString() {
    return 'Candidate(parts: ${parts?.map((e) => e.toString()).join(", ")})';
  }
}

class Part {
  final String? text;

  Part({this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(text: json['text'] as String?);
  }

  @override
  String toString() {
    return 'Part(text: $text)';
  }
}
