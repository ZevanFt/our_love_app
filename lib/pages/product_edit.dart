import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProductEditPage extends StatefulWidget {
  const ProductEditPage({super.key});

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _points = '';
  XFile? _imageFile;
  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      labelStyle: TextStyle(color: Colors.grey[700], fontFamily: 'SW-Kai'),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          '添加新宝贝',
          style: TextStyle(fontFamily: 'SW-Kai', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '宝贝图片',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SW-Kai',
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[300]!, width: 1.5),
                      image: _imageFile != null
                          ? DecorationImage(
                              image: FileImage(File(_imageFile!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imageFile == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '点击选择图片',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'SW-Kai',
                                  ),
                                ),
                              ],
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '宝贝信息',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SW-Kai',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: '名称'),
                  style: const TextStyle(fontFamily: 'SW-Kai'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入宝贝名称';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: '所需积分'),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontFamily: 'SW-Kai'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入所需积分';
                    }
                    if (int.tryParse(value) == null) {
                      return '请输入有效的数字';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _points = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: inputDecoration.copyWith(labelText: '数量'),
                  style: const TextStyle(fontFamily: 'SW-Kai'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入宝贝数量';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return '请输入一个有效的正整数';
                    }
                    return null;
                  },
                  // onSaved is no longer needed as the value is in the controller
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/store');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey[400]!),
                          foregroundColor: Colors.black87,
                        ),
                        child: const Text(
                          '取消',
                          style: TextStyle(
                            fontFamily: 'SW-Kai',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/store');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: const Color(0xFF7873f5),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          '确认添加',
                          style: TextStyle(
                            fontFamily: 'SW-Kai',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
