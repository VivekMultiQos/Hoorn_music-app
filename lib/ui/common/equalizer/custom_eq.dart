import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/constant/font_style.dart';

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange);

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  _CustomEQState createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  late double min, max;
  String? _selectedValue;
  late Future<List<String>> fetchPresets;
  Map<int, ValueNotifier<double>> bandValues = {};

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
    fetchPresets = EqualizerFlutter.getPresetNames();
    _fetchInitialBandLevels();
  }

  Future<void> _fetchInitialBandLevels() async {
    // Initialize band levels with ValueNotifier
    List<int> centerFreqs = await EqualizerFlutter.getCenterBandFreqs();
    for (int bandId = 0; bandId < centerFreqs.length; bandId++) {
      int bandLevel = await EqualizerFlutter.getBandLevel(bandId);
      bandValues[bandId] = ValueNotifier<double>(bandLevel.toDouble());
    }
    setState(() {}); // Trigger UI update after band levels are initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: EqualizerFlutter.getCenterBandFreqs(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _buildPresets(),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!
                        .asMap()
                        .entries
                        .map(
                            (entry) => _buildSliderBand(entry.key, entry.value))
                        .toList(),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildSliderBand(int bandId, int freq) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: ValueListenableBuilder<double>(
              valueListenable: bandValues[bandId] ?? ValueNotifier<double>(0.0),
              builder: (context, value, child) {
                return RotatedBox(
                  quarterTurns: 1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 1, trackShape: SliderCustomTrackShape()),
                    child: Slider(
                      min: min,
                      max: max,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      value: value,
                      onChanged: (newValue) {
                        bandValues[bandId]!.value = newValue;
                        EqualizerFlutter.setBandLevel(bandId, newValue.toInt());
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            '${freq ~/ 1000} Hz',
            style: AppFontStyle.h3Regular.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
      future: fetchPresets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final presets = snapshot.data;
          if (presets!.isEmpty) return const Text('No presets available!');
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Available Presets',
              border: OutlineInputBorder(),
              focusColor: Colors.black,
              labelStyle: AppFontStyle.h3Regular
                  .copyWith(color: Colors.white), // Label color
            ),
            style: AppFontStyle.h3Regular.copyWith(color: Colors.black),
            dropdownColor: Colors.white.withOpacity(0.8),
            iconEnabledColor: Colors.white,
            // Dropdown arrow color
            value: _selectedValue,
            onChanged: widget.enabled
                ? (String? value) {
                    EqualizerFlutter.setPreset(value!);
                    setState(() {
                      _selectedValue = value;
                    });
                  }
                : null,
            items: presets.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppFontStyle.h3Regular.copyWith(color: Colors.black),
                ),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return presets.map((String value) {
                return Text(
                  value,
                  style: AppFontStyle.h3Regular.copyWith(
                      color: Colors.white), // Selected item text color
                );
              }).toList();
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = (parentBox.size.height) / 2;
    final double trackWidth = 230;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}
