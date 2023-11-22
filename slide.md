## Intro
- Background on digital controller
- Primer for STM32 ADC & HRTIM
- STM32 toolchain
- Simple flashing demo

## Digital controller
- Accurate ADC
- Processing power for loop filter
- Arbitrary PWM generator

## Controller selection
- MCU: stm32 G4x4 series 
    - E.g. NUCLEO-G474RE (Mouser HK$132.10)
    - In C/C++ or embedded-Rust
    - Easier to learn but hard to be timing accurate
- FPGA: Xilinx Zynq 
    - E.g. PYNQ-Z2 (Mouser HK$1,900.88)
    - In python (PYNQ) or V*HDL language
    - Harder to learn but easier to implement timing critical application

## STM32 hardware - ADC
- 5 ADCs but some pins are shared with other IOs 
- 12bit@60MHz, minium sampling cycle = 2.5 CLK cycle 
- usually 3.3V (check datasheet for other variants)
- Can use DMA (Direct memory access) without wasting processor time

## STM32 hardware - HRTIM
- 6 channels with 2 outputs each
- 184 ps resolution
- Arbitrary PWM generator

## HRTIM - CMPx 
- CMPX (compare) == counter, IO can be set to
    - ON
    - OFF
    - Toggle
- 7 timers with 4+4 CMPs
    - Master timer: no IO but provides 4 CMPs to all timer
    - A-F timer: each has 4 CMPs

## Block diagram example 
```mermaid
flowchart LR
    subgraph cpu [STM32]
    direction LR
    ADC1 -- DMA --> filter1{{"Loop filter1"}}
    ADC2 -- DMA --> filter2{{"Loop filter2"}}
    ADC3 -- DMA --> filter3{{"Loop filter3"}}
    filter1 & filter2 & filter3 == CMPx ==> TIM["HRTIM"]
    end
    SIG1((SIG1)) --> ADC1
    SIG2((SIG2)) --> ADC2
    SIG3((SIG3)) --> ADC3
    TIM --PWMs--> SW((MOSFETs))
```


## Toolchain
- stm32cubeide
    - Code generation and eclipse editor
- stm32cubemx + openocd + editor of your choice
    - stm32cubemx: code generation
    - openocd: flashing and debugger support

## IDE Demo


## Other resource 
- [RM0440 Reference manual](https://www.st.com/resource/en/reference_manual/rm0440-stm32g4-series-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)
- [UM2570 hal and low-layer drivers manual](https://www.st.com/resource/en/user_manual/um2570-description-of-stm32g4-hal-and-lowlayer-drivers--stmicroelectronics.pdf)
- [AN4539 HRTIM coobok](https://www.st.com/resource/en/application_note/an4539-hrtim-cookbook-stmicroelectronics.pdf)
    - with DC-DC converters examples
- [G474 Code examples](https://github.com/STMicroelectronics/STM32CubeG4/tree/master/Projects/NUCLEO-G474RE/Examples)
---
# Happy coding