import 'dart:io';
import 'dihybrid_cross.dart';
import 'monohybrid_cross.dart';

class Input {
  static void crossingInput() {
    stdout.writeln("Monohybrid or dihybrid? M/D:");
    String? crossingChoice = stdin.readLineSync()?.toUpperCase();

    if (crossingChoice?.length != 1 || (crossingChoice != "M" && crossingChoice != "D")) {
      stdout.writeln("Error: Use M or D to decide your crossing type");
      return;
    }

    if (crossingChoice == "M") {
      stdout.writeln("Enter a letter to represent the trait (e.g., X,Z, or R):");
      String? traitLetter = stdin.readLineSync()?.toUpperCase();

      if (traitLetter == null || traitLetter.length != 1) {
        stdout.writeln("Error: Enter exactly 1 letter.");
        return;
      }

      stdout.writeln("Enter parent 1 alleles (e.g., $traitLetter${traitLetter.toLowerCase()}):");
      String? parent1 = stdin.readLineSync();

      stdout.writeln("Enter parent 2 alleles (e.g., $traitLetter${traitLetter.toLowerCase()}):");
      String? parent2 = stdin.readLineSync();

      if (parent1 == null || parent2 == null) {
        stdout.writeln("Error: Invalid input.");
        return;
      }

      Map<String, int> genotypeCounts = MonohybridCross.monohybridCross(parent1, parent2);

      stdout.writeln("\nGenotype Frequencies:");
      genotypeCounts.forEach((key, value) => stdout.writeln("$key: $value"));

      stdout.writeln("\nPhenotype Frequencies: ");
      Map<String, int> phenotypeCounts = getPhenotypes(genotypeCounts, traitLetter);
      int total = phenotypeCounts.values.fold(0, (sum, value) => sum + value);

      phenotypeCounts.forEach((key, value) {
        double percentage = (value / total) * 100;
        stdout.writeln("$key: $value (${percentage.toStringAsFixed(2)}%)");
      });

      stdout.writeln("\nDo another set? Y/N:");
      String? continueChoice = stdin.readLineSync()?.toUpperCase();

      if (continueChoice == "Y") {
        crossingInput();
      } else if (continueChoice == "N") {
        return;
      }
    }
    else if (crossingChoice == "D") {
      stdout.writeln("Enter two letters to represent the traits (e.g., XZ):");
      String? traitLetters = stdin.readLineSync()?.toUpperCase();

      if (traitLetters == null || traitLetters.length != 2 || traitLetters[0] == traitLetters[1]) {
        stdout.writeln("Error: Enter exactly two different letters.");
        return;
      }

      String trait1 = traitLetters[0];
      String trait2 = traitLetters[1];

      stdout.writeln("Enter parent 1 alleles (e.g., $trait1$trait1$trait2$trait2):");
      String? parent1 = stdin.readLineSync();

      stdout.writeln("Enter parent 2 alleles (e.g., $trait1$trait1$trait2$trait2):");
      String? parent2 = stdin.readLineSync();

      if (parent1 == null || parent2 == null) {
        stdout.writeln("Error: Invalid input.");
        return;
      }

      Map<String, int> genotypeCounts = DihybridCross.dihybridCross(parent1, parent2);

      stdout.writeln("\nGenotype Frequencies:");
      genotypeCounts.forEach((key, value) => stdout.writeln("$key: $value"));

      stdout.writeln("\nPhenotype Frequencies:");
      Map<String, int> phenotypeCounts = getPhenotypes(genotypeCounts, trait1, trait2);
      int total = phenotypeCounts.values.fold(0, (sum, value) => sum + value);

      phenotypeCounts.forEach((key, value) {
        double percentage = (value / total) * 100;
        stdout.writeln("$key: $value (${percentage.toStringAsFixed(2)}%)");
      });

      stdout.writeln("\nDo another set? Y/N:");
      String? continueChoice = stdin.readLineSync()?.toUpperCase();

      if (continueChoice == "Y") {
        crossingInput();
      } else if (continueChoice == "N") {
        return;
      }

    }
  }
  static Map<String, int> getPhenotypes(Map<String, int> genotypeCounts, String trait1, [String? trait2]) {
    Map<String, int> phenotypeCounts = {};

    genotypeCounts.forEach((genotype, count) {
      String phenotype = getPhenotype(genotype, trait1, trait2);
      phenotypeCounts[phenotype] = (phenotypeCounts[phenotype] ?? 0) + count;
    });

    return phenotypeCounts;
  }


  static String getPhenotype(String genotype, String trait1, [String? trait2]) {
    bool hasDominantTrait1 = genotype.contains(trait1);
    String trait1Desc = hasDominantTrait1 ? "Dominant $trait1" : "Recessive ${trait1.toLowerCase()}";

    String trait2Desc = "";
    if (trait2 != null) {
      bool hasDominantTrait2 = genotype.contains(trait2);
      trait2Desc = hasDominantTrait2 ? "Dominant $trait2" : "Recessive ${trait2.toLowerCase()}";
    }

    if (trait2 != null) {
      return "$trait1Desc, $trait2Desc";
    }

    return trait1Desc;
  }

}