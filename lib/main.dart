import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _tfController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Create a FocusNode
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  final ScrollController _scrollController = ScrollController();

  List<String> applicants = [
    'irhow@umich.edu',
    'idemelo@umich.edu',
    'ikalwani@umich.edu',
    'ishakok@umich.edu',
    'joelyson@umich.edu',
    'kskyekim@umich.edu',
    'lindsee@umich.edu',
    'vincegmz@umich.edu',
    'angan@umich.edu',
    'jamalvh@umich.edu',
    'sunrw@umich.edu',
    'cassiez@umich.edu',
    'phjus@umich.edu',
    'isaachyw@umich.edu',
    'jiajunxi@umich.edu',
    'athomare@umich.edu',
    'sincheol@umich.edu',
    'maddjenn@umich.edu',
    'brboyce@umich.edu',
    'jmaydan@umich.edu',
    'rsta@umich.edu',
    'mengjc@umich.edu',
  ];

  @override
  void dispose() {
    _tfController.dispose();
    _focusNode.dispose(); // Dispose of the FocusNode
    _confettiController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleAddApplicant() {
    setState(() {
      if (_tfController.text.isNotEmpty) {
        String email = "${_tfController.text}@umich.edu";
        if (!applicants.contains(email)) {
          // ignore: avoid_print
          print("'$email',");
          applicants.insert(0, email); // Add new applicant to the front
          _confettiController.play(); // Show confetti
        }
        _tfController.clear();
        _scrollToTop();
        _focusNode.requestFocus(); // Request focus after adding applicant
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          const Image(
            width: 1000,
            image: AssetImage('gdsc_logo.png'),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.orange
            ],
          ),
          const SizedBox(height: 50),
          Text(
            "Join the mailing list, alongside ${applicants.length} others!",
            style: const TextStyle(fontSize: 50, color: Colors.grey),
          ),
          const SizedBox(height: 50),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _tfController,
                    focusNode: _focusNode, // Assign the FocusNode
                    decoration: InputDecoration(
                      hintText: "Uniqname",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: false,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400), // Gray border color
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400), // Gray border color
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    onSubmitted: (_) => _handleAddApplicant(),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  "@umich.edu",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 251, 188, 5),
                    minimumSize: const Size(50, 50), // Adjust the size here
                  ),
                  onPressed: _handleAddApplicant,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          // Applicants List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                controller: _scrollController,
                reverse: false, // Ensure new items are at the top
                itemCount: applicants.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      applicants[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
