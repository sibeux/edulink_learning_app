import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/components/toast.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:edulink_learning_app/controllers/user_profile_controller.dart';
import 'package:edulink_learning_app/models/student_courses.dart';
import 'package:edulink_learning_app/widgets/complete_profile/form/teacher/courses_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CoursesPickerAccountInfo extends StatefulWidget {
  const CoursesPickerAccountInfo({
    super.key,
    required this.completeProfileController,
    required this.needEditing,
    required this.isHasInvalid,
  });

  final CompleteProfileController completeProfileController;
  final bool needEditing, isHasInvalid;

  @override
  State<CoursesPickerAccountInfo> createState() =>
      _CoursesPickerAccountInfoState();
}

class _CoursesPickerAccountInfoState extends State<CoursesPickerAccountInfo> {
  // 'Tali' penghubung antara widget anchor dan dropdown
  final LayerLink _layerLink = LayerLink();

  // Controller untuk overlay
  OverlayEntry? _overlayEntry;
  bool _isOverlayVisible = false;

  final ScrollController _dropdownScrollController = ScrollController();

  @override
  void dispose() {
    // Pastikan overlay dihapus untuk menghindari memory leak
    _hideOverlay();
    _dropdownScrollController.dispose();
    super.dispose();
  }

  void _toggleOverlay() {
    if (_isOverlayVisible) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry(
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOverlayVisible = true;
    });
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {
        _isOverlayVisible = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    // Kita tidak lagi memerlukan RenderBox untuk mendapatkan ukuran anchor
    // final renderBox = context.findRenderObject() as RenderBox;
    // final size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              // Layer untuk mendeteksi klik di luar dropdown untuk menutupnya
              Positioned.fill(
                child: GestureDetector(
                  onTap: _hideOverlay,
                  // Beri sedikit warna gelap untuk efek modal
                  child: Container(color: Colors.black.withValues(alpha: 0.3)),
                ),
              ),
              // Gunakan Center untuk menempatkan konten di tengah layar
              Center(
                child: Padding(
                  // Beri padding agar tidak menempel di tepi layar
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Material(
                    color: Colors.transparent,
                    child: _buildDropdownContent(
                      // Gunakan lebar layar, bukan lebar anchor
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Interest',
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            widget.isHasInvalid
                ? Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red.withValues(alpha: 1),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
                : SizedBox(),
          ],
        ),
        SizedBox(
          height:
              widget.completeProfileController.coursesList.isEmpty
                  ? 10.h
                  : 15.h,
        ),
        // Widget "Jangkar" yang akan diikuti oleh dropdown
        CompositedTransformTarget(
          link: _layerLink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // Menampilkan pilihan jika ada, atau teks placeholder jika kosong
                    child:
                        widget.completeProfileController.coursesList.isEmpty
                            ? Text(
                              'No Set',
                              style: TextStyle(
                                color: HexColor('#B4B4B4'),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                            : Wrap(
                              spacing: 8.w,
                              runSpacing: 15.h,
                              children:
                                  widget.completeProfileController.coursesList
                                      .map(
                                        (course) => Padding(
                                          padding: EdgeInsets.only(
                                            right: 6.w,
                                          ), // Memberi jarak antar Chip
                                          child: Chip(
                                            label: Text(course.capitalize!),
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: VisualDensity(
                                              horizontal: -4,
                                              vertical: -4,
                                            ),
                                            // Menambahkan ikon 'x' untuk menghapus
                                            deleteIcon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 18.sp,
                                            ),
                                            // Fungsi yang akan dipanggil saat ikon 'x' ditekan
                                            onDeleted:
                                                widget.needEditing
                                                    ? () {
                                                      // Panggil setState untuk memperbarui UI setelah item dihapus
                                                      setState(() {
                                                        widget
                                                            .completeProfileController
                                                            .coursesList
                                                            .remove(course);
                                                      });
                                                    }
                                                    : null,
                                            backgroundColor:
                                                ColorPalette().primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            side: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              if (widget.needEditing)
                GestureDetector(
                  onTap: () {
                    if ((widget
                            .completeProfileController
                            .selectedEducationType
                            .isNotEmpty ||
                        Get.find<UserProfileController>()
                                .userData[0]
                                .userActor !=
                            'student')) {
                      _toggleOverlay();
                    } else {
                      showToast('Please select education type first');
                    }
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: ColorPalette().primary,
                    size: 30.sp,
                  ),
                ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  // Widget untuk konten dropdown yang muncul
  Widget _buildDropdownContent(double width) {
    // StatefulBuilder digunakan agar UI di dalam dropdown bisa update (misal saat memilih chip)
    // tanpa perlu membangun ulang seluruh halaman.
    return StatefulBuilder(
      builder: (context, dropdownSetState) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            // Atur tinggi maksimum dropdown di sini
            maxHeight: 300.h,
          ),
          child: Container(
            width: width,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: HexColor('#000000').withValues(alpha: 0.12),
                  blurRadius: 16,
                  spreadRadius: -2,
                  offset: const Offset(2, 5),
                ),
              ],
            ),
            child: Scrollbar(
              thumbVisibility: true,
              controller: _dropdownScrollController,
              child: SingleChildScrollView(
                controller: _dropdownScrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coursesFilterChip(
                      dropdownSetState: dropdownSetState,
                      coursesList:
                          Get.find<UserProfileController>()
                                      .userData[0]
                                      .userActor ==
                                  'student'
                              ? studentCourses[widget
                                      .completeProfileController
                                      .selectedEducationType
                                      .value
                                      .toUpperCase()]!
                                  .toSet()
                                  .toList()
                              : teacherAllCourses.toSet().toList(),
                      runSpacing: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Wrap coursesFilterChip({
    required StateSetter dropdownSetState,
    required List<String> coursesList,
    required double runSpacing,
  }) {
    return Wrap(
      spacing: 8.w,
      runSpacing: runSpacing,
      children:
          coursesList.map((course) {
            final isSelected = widget.completeProfileController.coursesList
                .contains(course);
            return FilterChip(
              label: Text(course.capitalize!),
              selected: isSelected,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              materialTapTargetSize:
                  MaterialTapTargetSize
                      .shrinkWrap, // Biar lebih kecil (mengurangi padding default)
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              selectedColor: ColorPalette().primary,
              checkmarkColor: Colors.white,
              showCheckmark: false,
              backgroundColor:
                  isSelected ? ColorPalette().primary : HexColor('#E5ECFF'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              side: BorderSide(color: Colors.transparent),
              onSelected: (bool selected) {
                // Logika untuk menambah/menghapus pilihan
                dropdownSetState(() {
                  if (selected) {
                    widget.completeProfileController.coursesList.add(course);
                  } else {
                    widget.completeProfileController.coursesList.remove(course);
                  }
                });
                // Memperbarui UI di luar dropdown (anchor)
                setState(() {});
              },
            );
          }).toList(),
    );
  }
}
