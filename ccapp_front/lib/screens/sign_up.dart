import 'package:ccapp_front/style/colors.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController idController;
  late final TextEditingController pwController;
  late final TextEditingController pwConfirmController;
  late final TextEditingController nicknameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    pwConfirmController = TextEditingController();
    nicknameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CCColor.grey100,
        iconTheme: const IconThemeData(color: CCColor.grey900),
        elevation: 0,
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontFamily: 'Pretendard',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: pwController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CCColor.secondary),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: pwConfirmController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CCColor.secondary),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: nicknameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: '닉네임',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CCColor.secondary),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: '전화번호',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: CCColor.secondary),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CCColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.fromLTRB(130, 12, 130, 12),
                  elevation: 0,
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  idController.clear();
                  pwController.clear();
                  pwConfirmController.clear();
                  nicknameController.clear();
                  phoneController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  '기존 아이디로 로그인',
                  style: TextStyle(
                    color: CCColor.grey400,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
