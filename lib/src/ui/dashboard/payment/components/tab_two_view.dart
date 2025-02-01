import 'package:flutter/material.dart';



class TabBarWidgetTwo extends StatelessWidget {

   TabBarWidgetTwo({Key? key}) : super(key: key);
  TextEditingController controllerCardHolderName = TextEditingController();
  TextEditingController controllerCardNumber = TextEditingController();
  TextEditingController controllerExpiryDate = TextEditingController();
  TextEditingController controllerCVV = TextEditingController();
  TextEditingController controllerAccountNumber = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerBranchName = TextEditingController();
  TextEditingController controllerRemarks = TextEditingController();
  TextEditingController controllerAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transfer Mode",
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                transferModeTextWidget("NEFT", Colors.blue),
                const SizedBox(width: 20),
                transferModeTextWidget("RTGS", Colors.grey),
                const SizedBox(width: 20),
                transferModeTextWidget("IMPS", Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Note : NEFT transfer money within 1 Hour",
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            _buildInputField("Account Number", controllerAccountNumber, "Enter account number"),
            _buildInputField("Name", controllerName, "Enter name"),
            _buildInputField("Branch Name", controllerBranchName, "Enter branch name"),
            _buildInputField("Remarks (Optional)", controllerRemarks, "Enter remarks"),
            _buildInputField("Amount", controllerAmount, "Enter amount"),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xff475569),
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          maxLength: 50,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

Widget transferModeTextWidget(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
