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
                      cursorColor: Colors.deepOrange,
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
                      onPressed: reviewProvider.state is ReviewSubmittingState
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await reviewProvider.addReview(
                                  reviewProvider.nameController.text,
                                  reviewProvider.reviewController.text,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      reviewProvider.state is ReviewErrorState
                                          ? (reviewProvider.state
                                                  as ReviewErrorState)
                                              .message
                                          : 'Ulasan berhasil dikirim!',
                                    ),
                                    backgroundColor:
                                        reviewProvider.state is ReviewErrorState
                                            ? Colors.red
                                            : Colors.green,
                                  ),
                                );
                              }
                            },
                      child: reviewProvider.state is ReviewSubmittingState
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
