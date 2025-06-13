// Widget yang berisi konten untuk ditampilkan di dalam bottom sheet
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormBottomSheet extends StatelessWidget {
  const FormBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Padding ini penting agar keyboard tidak menutupi TextField
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        // Dekorasi untuk membuat sudut atas membulat dan memberi warna latar
        decoration: BoxDecoration(
          color: Color(0xFFf0f0f0), // Warna abu-abu muda
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0.r),
            topRight: Radius.circular(20.0.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            // `mainAxisSize.min` membuat tinggi Column sesuai dengan kontennya
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Label Teks
              const Text(
                'Ask EduBot anything about your school problems!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              // 2. Input Teks Panjang
              TextField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                autofocus:
                    false, // Tidak langsung fokus ke text field saat muncul
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Type your question here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // 3. Tombol "Next"
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text('Send Question'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
