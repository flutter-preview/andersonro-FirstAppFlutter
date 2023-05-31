import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trilhaapp/pages/main_page.dart';
import 'package:trilhaapp/shared/widgets/app_prefs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var senhaController = TextEditingController();

  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                //maxWidth:  MediaQuery.of(context).size.width,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 6,
                          child: Container(
                              child: Image.network(
                                  "https://hermes.digitalinnovation.one/assets/diome/logo.png")),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25),
                      child: const Text(
                        "Já tem cadastro?",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 25),
                      child: const Text(
                        "Faça seu login maje the change_?",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                    height: 30,
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: -5),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 141, 79, 151))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 141, 79, 151))),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 141, 79, 151),
                          ),
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(30, 15, 30, 5),
                    height: 30,
                    child: TextField(
                      controller: senhaController,
                      onChanged: (value) {
                        debugPrint(value);
                      },
                      obscureText: isObscureText,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: -5),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 141, 79, 151))),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 141, 79, 151))),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 141, 79, 151),
                          ),
                          hintText: "Senha",
                          hintStyle: const TextStyle(color: Colors.white),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscureText = !isObscureText;
                              });
                            },
                            child: Icon(
                                isObscureText ? Icons.visibility_off : Icons.visibility,
                                color: const Color.fromARGB(255, 141, 79, 151)),
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          if (emailController.text.trim() == "teste@teste.com.br" &&
                              senhaController.text.trim() =="123") {

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(AppPrefs.APP_PREFS_EMAIL, emailController.text);

                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const MainPage()));

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Usuário ou senha incorretos!",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255)
                                    ),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 141, 80, 115),
                                )
                            );
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 141, 79, 151))),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                    alignment: Alignment.center,
                    child: const Text(
                      "Esqueci minha senha",
                      style: TextStyle(
                          color: Colors.yellowAccent, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                    alignment: Alignment.center,
                    child: const Text(
                      "Criar conta",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
