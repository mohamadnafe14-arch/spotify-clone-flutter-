import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/functions/pick_image.dart';
import 'package:spotify_clone/core/functions/pick_song.dart';
import 'package:spotify_clone/core/functions/show_snack_bar.dart';
import 'package:spotify_clone/core/theme/app_palette.dart';
import 'package:spotify_clone/core/widgets/custom_text_form_field.dart';
import 'package:spotify_clone/core/widgets/loader.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';
import 'package:spotify_clone/features/home/views/widgets/waveform_widget.dart';

class AddSongView extends ConsumerStatefulWidget {
  const AddSongView({super.key});

  @override
  ConsumerState<AddSongView> createState() => _AddSongViewState();
}

class _AddSongViewState extends ConsumerState<AddSongView> {
  late GlobalKey<FormState> formKey;
  File? _image, _song;
  String? _title, _artist;
  Color _color = Pallete.cardColor;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(homeViewmodelProvider.select((x) => x?.isLoading)) ?? false;
    ref.listen(homeViewmodelProvider, (_, next) {
      if (next is AsyncError) {
        showSnackBar(next.error.toString(), context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Song"),
        actions: [
          IconButton(
            onPressed: () {
              if (_image == null) {
                showSnackBar("Please add an image", context);
              }
              if (_song == null) {
                showSnackBar("Please add a song", context);
              }
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                ref
                    .read(homeViewmodelProvider.notifier)
                    .uploadSong(
                      thumbnail: _image!,
                      song: _song!,
                      songName: _title!,
                      artist: _artist!,
                      color: _color,
                    );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DottedBorder(
                        options: RectDottedBorderOptions(
                          dashPattern: [10, 5],
                          strokeWidth: 2,
                          color: Pallete.borderColor,
                          strokeCap: StrokeCap.round,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final image = await pickImage();
                            if (image != null) {
                              setState(() {
                                _image = image;
                              });
                            }
                          },
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image.file(
                                    _image!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo, size: 50),
                                      SizedBox(height: 10),
                                      Text('Add Photo'),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _song == null
                          ? CustomTextFormField(
                              hintText: "Choose a song",
                              validator: (value) => null,
                              onSaved: (value) {},
                              readonly: true,
                              onTap: () async {
                                final song = await pickSong();
                                if (song != null) {
                                  setState(() {
                                    _song = song;
                                  });
                                }
                              },
                            )
                          : WaveformWidget(path: _song!.path),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: "Artist Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter artist name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _artist = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hintText: "Song Title",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter song title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      ColorPicker(
                        color: _color,
                        pickersEnabled: const <ColorPickerType, bool>{
                          ColorPickerType.primary: true,
                          ColorPickerType.accent: true,
                          ColorPickerType.wheel: true,
                        },
                        onColorChanged: (color) {
                          setState(() {
                            _color = color;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
