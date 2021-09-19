# Assembly Language in Visual Studio

## Introduction

This presentation will demonstrate how to set up a project in Visual Studio to write, assemble, run, and debug assmebly code using the Microsoft Assembler (MASM), which is included with Visual Studio. This is not a tutorial on assembly, and I am not qualified to give such a tutorial. Rather, the purpose of this presentation is to explore a capability of Visual Studio that most users may never encounter, and to do some low-level programming.

## What is assembly language?

Assembly language is a low-level programming language with a nearly one-to-one correspondence with the computer's machine code instructions. It is mostly a set of mnemonic codes referring to machine codes. Assembly language is converted into machine code by an assembler, whereas higher-level languages like C# are compiled by a compiler, which may make decisions on its own based on the entirety of the program.

## Setting up a Visual Studio project to write assembly

- Install an assembly language plugin to add intellisence and syntax highlighting. I used [AsmDude](https://marketplace.visualstudio.com/items?itemName=Henk-JanLebbink.AsmDude), and there are others.
- Create a new empty C++ project (don't worry, this isn't going to be just a C++ program with inline assembly)
- Right-click on the project, go to `Build Dependencies -> Build Customizations` and select `masm`
- Add a file to the project with the `.asm` extension
- To make assembly programming easier, download the library files from <http://asmirvine.com/gettingStartedVS2019/index.htm>. To use these libraries in your programs:
  - right click the project in Visual Studio, go to Microsoft Macro `Assembler -> General` and add the directory to those library files to `Include Paths`
  - go to `Linker -> General` and add that directory to `Additional Library Directories`
  - go to `Linker -> Input` and add `Irvine32.lib` to `Additional Dependencies`

## Program Basics

- `.386` tells the assembler to use the .386 instruction set
- `.model flat, stdcall`
  - model is a directive specifying the memory model of the program, and `flat` is the model for Windows programs
  - `stdcall` is the method for passing parameters to Windows functions, indicating that parameters are pushed from right to left
