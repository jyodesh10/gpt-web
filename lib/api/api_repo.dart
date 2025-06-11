
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpt_web/constants/constants.dart';
import 'package:http/http.dart' as http;

class ApiRepo {
  Future<String> geminiApiPost(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse(baseurl),
        body: jsonEncode(
          {
            "contents": [
              {
                "parts": [
                  {"text": prompt},
                ],
              },
            ],
          },
        ) 
      );
      if (res.statusCode == 200) {
        // debugPrint('Parsed API Response: ${res.body}');
        // var data = jsonDecode(res.body);
        // var promptModel = PromptModel.fromJson(data);
        // debugPrint('Parsed API Response: ${promptModel.toString()}');

        // if (promptModel.candidates != null &&
        //     promptModel.candidates!.isNotEmpty &&
        //     promptModel.candidates![0].parts != null &&
        //     promptModel.candidates![0].parts!.isNotEmpty &&
        //     promptModel.candidates![0].parts![0].text != null) {
        //   return promptModel.candidates![0].parts![0].text!;
        // } else {
        //   debugPrint("Could not extract text from API response structure: $data");
        //   return "Error: Could not parse response content.";
        // }
        var data =  json.decode(res.body);
        return data['candidates'][0]['content']['parts'][0]['text'].toString();
      } else {
        debugPrint("API request failed with status: ${res.statusCode}, body: ${res.body}");
        return "Error: API request failed (${res.statusCode}).";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
