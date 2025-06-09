import 'package:edulink_learning_app/components/color_palette.dart';
import 'package:edulink_learning_app/controllers/complete_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hexcolor/hexcolor.dart';

// Widget CoursesPicker yang sudah diubah menjadi StatefulWidget
class CoursesPicker extends StatefulWidget {
  const CoursesPicker({super.key, required this.completeProfileController});

  final CompleteProfileController completeProfileController;

  @override
  State<CoursesPicker> createState() => _CoursesPickerState();
}

// Daftar data untuk dropdown
final List<String> topCourses = ['math', 'science', 'english'];
final List<String> teacherAllCourses = [
  "english",
  "indonesian language",
  "traditional language",
  "biology",
  "physics",
  "geography",
  "history",
  "social sciences",
  "math",
  'automotive',
  'science',
  'engineering',
  'agriculture',
  'health',
  'hospitality',
  'tourism',
  'media and broadcasting',
  'business and marketing',
  'entrepreneurship',
  "information technology and computer",
  "sports",
  "art and culture",
  "religious education",
  'pancasila education',
  "physical education",
  "sociology",
  "economics",
  "chemistry",
  "computer science",
  "civics",
  "psychology",
  'fiqh',
  'aqidah akhlak',
  'quran hadith',
  'arabic language',
];

class _CoursesPickerState extends State<CoursesPicker> {
  // 'Tali' penghubung antara widget anchor dan dropdown
  final LayerLink _layerLink = LayerLink();

  // Controller untuk overlay
  OverlayEntry? _overlayEntry;
  bool _isOverlayVisible = false;

  final ScrollController _dropdownScrollController = ScrollController();
  final ScrollController _selectedCoursesScrollController = ScrollController();

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
      completeProfileController: widget.completeProfileController,
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

  OverlayEntry _createOverlayEntry({
    required CompleteProfileController completeProfileController,
  }) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              // Layer untuk mendeteksi klik di luar dropdown untuk menutupnya
              Positioned.fill(
                child: GestureDetector(
                  onTap: _hideOverlay,
                  child: Container(color: Colors.transparent),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(
                  0.0,
                  size.height - 10.h,
                ), // Offset untuk menampilkan dropdown di bawah anchor
                child: Material(
                  color:
                      Colors.transparent, // Material diperlukan untuk elevation
                  child: _buildDropdownContent(size.width),
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
              'Courses',
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        // Widget "Jangkar" yang akan diikuti oleh dropdown
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleOverlay,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
              child: Row(
                children: [
                  Expanded(
                    // Menampilkan pilihan jika ada, atau teks placeholder jika kosong
                    child:
                        widget.completeProfileController.coursesList.isEmpty
                            ? Text(
                              'Choose Courses',
                              style: TextStyle(
                                color: HexColor('#B4B4B4'),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                            : Scrollbar(
                              thumbVisibility: true,
                              controller: _selectedCoursesScrollController,
                              child: SingleChildScrollView(
                                controller: _selectedCoursesScrollController,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      widget
                                          .completeProfileController
                                          .coursesList
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
                                                onDeleted: () {
                                                  // Panggil setState untuk memperbarui UI setelah item dihapus
                                                  setState(() {
                                                    widget
                                                        .completeProfileController
                                                        .coursesList
                                                        .remove(course);
                                                  });
                                                },
                                                backgroundColor:
                                                    ColorPalette().primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        20.r,
                                                      ),
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
                            ),
                  ),
                  Icon(
                    _isOverlayVisible
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: ColorPalette().primary,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.h),
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
                    // Anda bisa menambahkan TextField pencarian di sini jika perlu
                    Text(
                      'Top Courses',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    coursesFilterChip(
                      dropdownSetState: dropdownSetState,
                      coursesList: topCourses,
                      runSpacing: 4.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'All',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    coursesFilterChip(
                      dropdownSetState: dropdownSetState,
                      coursesList: teacherAllCourses.toSet().toList(),
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
