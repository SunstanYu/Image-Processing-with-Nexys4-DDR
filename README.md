# VHDL Image Processing System

## Project Overview

This project is an FPGA-based image processing system that implements two functional modes: static image processing and real-time image processing. Users can switch between different modes by pressing buttons, and the processed images will be displayed on a VGA display screen. The system supports various image processing operations including grayscale processing, color gamut conversion, color inversion, and other operations, with a designed UI for better image display and comparison.

## Key Features

### 🖼️ Dual-Mode Image Processing
- **Static Image Processing Mode**: Process pre-stored static images
- **Real-time Image Processing Mode**: Real-time processing of camera-captured images
- **Mode Switching**: Seamless switching between two modes via button press

### 🎨 Image Processing Algorithms
- **Grayscale Conversion**: Convert color images to grayscale
- **Color Gamut Conversion**: RGB to other color space conversions
- **Color Inversion**: Image color inversion processing
- **Other Image Processing Operations**: Support for various image enhancement and filtering algorithms

### 🖥️ User Interface
- **VGA Display**: High-resolution image display
- **Image Comparison**: Simultaneous display of original and processed images
- **Status Indicators**: LED indicators showing current processing status

### 🔊 Audio Feedback
- **Mode Switch Tones**: Different prompt tones for different processing modes
- **Processing Complete Alerts**: Audio feedback when image processing is complete

## Hardware Platform

- **Development Board**: Nexys A7-100T FPGA Development Board
- **Camera**: OV7670 CMOS Image Sensor
- **Display**: VGA Monitor
- **Audio**: On-board Speaker

## Project Structure

```
image_processing/
├── image_processing.srcs/
│   ├── sources_1/new/           # VHDL source code files
│   │   ├── top_design.vhd      # Top-level design file
│   │   ├── camera_controller.vhd    # Camera controller
│   │   ├── image_capture.vhd        # Image capture module
│   │   ├── processing_unit.vhd      # Image processing unit
│   │   ├── vga_controller.vhd       # VGA controller
│   │   ├── audio.vhd               # Audio control module
│   │   └── ...                     # Other module files
│   └── constrs_1/new/
│       └── con_camera.xdc          # Pin constraint file
├── image_processing.ip_user_files/
│   └── mem_init_files/             # Memory initialization files
│       ├── image1.mif              # Static image data
│       └── blk_mem_gen_1.mif       # Memory initialization file
└── README.md                       # Project documentation
```

## Module Descriptions

### 1. Top-level Design (top_design.vhd)
- Main system interface and control logic
- Integration of all sub-modules
- User input handling and mode switching

### 2. Camera Controller (camera_controller.vhd)
- OV7670 camera initialization and control
- I2C communication protocol implementation
- Image data acquisition

### 3. Image Processing Unit (processing_unit.vhd)
- Implementation of various image processing algorithms
- Support for both real-time and static processing modes
- Configurable processing parameters

### 4. VGA Controller (vga_controller.vhd)
- VGA display timing control
- Image data display output
- Support for multiple resolutions

### 5. Audio Module (audio.vhd)
- Audio tone generation
- Audio feedback for different modes
- PWM audio output

## Usage Instructions

### 1. Hardware Connection
- Connect OV7670 camera to the development board
- Connect VGA display
- Ensure speaker connection is proper

### 2. Software Configuration
1. Open the project file `image_processing.xpr` using Vivado
2. Check the pin constraint file `con_camera.xdc`
3. Synthesize and generate bitstream file
4. Download to FPGA development board

### 3. Operation Guide
- **Mode Switching**: Press `btn` button to switch between static/real-time processing modes
- **Processing Method Selection**: Use `method[2:0]` switches to select different image processing methods
- **Status Monitoring**: Observe `is_processing` LED to understand current processing status
- **Audio Feedback**: Pay attention to different prompt tones for different modes

## Technical Specifications

- **FPGA**: Xilinx Artix-7 (XC7A100T)
- **Clock Frequency**: 100MHz system clock
- **Image Resolution**: Supports multiple resolutions (depends on camera configuration)
- **VGA Output**: Standard VGA interface
- **Audio Output**: PWM audio output

## Development Environment

- **Development Tool**: Xilinx Vivado 2020.2
- **Hardware Description Language**: VHDL
- **Simulation Tool**: Vivado built-in simulator

## File Descriptions

### Source Code Files
- `top_design.vhd`: Top-level design, main system controller
- `camera_controller.vhd`: Camera control module
- `image_capture.vhd`: Image data capture
- `processing_unit.vhd`: Core image processing algorithms
- `vga_controller.vhd`: VGA display control
- `audio.vhd`: Audio output control
- `debounce.vhd`: Button debouncing
- `i2c_sender.vhd`: I2C communication protocol
- `rgb_generator.vhd`: RGB color generation
- `address_generator.vhd`: Address generator
- `apply_kernel_unit.vhd`: Convolution kernel application unit

### Configuration Files
- `con_camera.xdc`: Pin constraints and timing constraints
- `image1.mif`: Static image data file
- `blk_mem_gen_1.mif`: Memory initialization file

## Important Notes

1. **Power Requirements**: Ensure stable power supply to the development board
2. **Camera Configuration**: OV7670 requires proper I2C configuration
3. **VGA Connection**: Ensure VGA display supports the configured resolution
4. **Audio Output**: Check speaker connection and volume settings
5. **Pin Constraints**: Adjust pin constraint file according to actual hardware connections

## Future Enhancements

- Support for more image processing algorithms
- Add image storage functionality
- Implement image format conversion
- Add network transmission capability
- Support touch screen control

## License

MIT License

Copyright (c) 2024 VHDL Image Processing System

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Contact

For questions or suggestions, please contact through the project repository.

---

**Note**: This project involves hardware design. Please ensure you have the necessary FPGA development experience and follow relevant safety operation procedures when using this project.
