import 'dart:convert';

import 'package:ccapp_front/main.dart';
import 'package:ccapp_front/models/user.dart';
import 'package:ccapp_front/screens/sign_up.dart';
import 'package:ccapp_front/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController idController;
  late final TextEditingController pwController;

  static const storage = FlutterSecureStorage();
  final String baseUrl = '125.129.144.42:3000';
  AccessToken? token;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkLogin());
  }

  Future<void> _checkLogin() async {
    final stored = await storage.read(key: 'login');
    if (stored == null) return;
    token = AccessToken.fromJson(jsonDecode(stored));
    push(token);
  }

  void loginAction(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://$baseUrl/login'),
        body: jsonEncode({
          'EMAIL': email,
          'PASSWORD': password,
        }),
      );

      if (response.statusCode == 200) {
        await storage.write(key: 'login', value: response.body);
        push(AccessToken.fromJson(jsonDecode(response.body)));
      }
    } catch (e) {
      print('api fetch failed on: $e');
    }
  }

  void push(AccessToken? token) {
    print(':: ${token?.accessToken}');
    if (token == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('로그인에 실패했습니다.'),
          actions: [
            Center(
              child: TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('확인'),
              ),
            ),
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CCApp',
                style: TextStyle(
                  fontFamily: 'Accountant',
                  fontSize: 64,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: idController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CCColor.secondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: pwController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(labelText: '비밀번호'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => loginAction(
                  idController.text,
                  pwController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CCColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.fromLTRB(130, 12, 130, 12),
                  elevation: 0,
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '아이디 찾기',
                      style: TextStyle(
                        color: CCColor.grey400,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const Text(
                    '/',
                    style: TextStyle(
                      color: CCColor.grey400,
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        color: CCColor.grey400,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  idController.clear();
                  pwController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: CCColor.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                ),
                child: const Text(
                  '로그인이 처음이신가요? 회원가입하기',
                  style: TextStyle(
                    color: CCColor.primary,
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
