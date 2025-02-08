import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/review_provider.dart';

class FieldReviewDetail extends StatefulWidget {
  const FieldReviewDetail({super.key});

  @override
  _FieldReviewDetailState createState() => _FieldReviewDetailState();
}

class _FieldReviewDetailState extends State<FieldReviewDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ReviewProvider>(
              builder: (context, reviewProvider, child) {
                return Column(
                  children: [
                    TextFormField(
                      controller: reviewProvider.nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Anda',
                        labelStyle: const TextStyle(color: Colors.deepOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.deepOrange, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.deepOrange, width: 2),
                        ),
                      ),
                      cursorWidth: 3.0, // Set the cursor width
                      cursorColor: Colors.deepOrange, // Set the cursor color
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: reviewProvider.reviewController,
                      decoration: InputDecoration(
                        labelText: 'Tulis Ulasan',
                        labelStyle: const TextStyle(color: Colors.deepOrange),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.deepOrange, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors.deepOrange, width: 2),
                        ),
                      ),
                      maxLines: 4,
                      cursorWidth: 3.0,
                      cursorColor: Colors.deepOrange,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ulasan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: reviewProvider.isSubmitting
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await reviewProvider.addReview(
                                  reviewProvider.nameController.text,
                                  reviewProvider.reviewController.text,
                                );
                                if (reviewProvider.errorMessage.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text(reviewProvider.errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Ulasan berhasil dikirim!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              }
                            },
                      child: reviewProvider.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Kirim Ulasan'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
