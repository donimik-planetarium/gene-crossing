class DihybridCross {
  static List<String> getGametes(String alleles) {
    List<String> gametes = [];
    List<String> gene1 = [alleles[0], alleles[1]];
    List<String> gene2 = [alleles[2], alleles[3]];

    for (var g1 in gene1) {
      for (var g2 in gene2) {
        gametes.add('$g1$g2');
      }
    }
    return gametes;
  }

  static Map<String, int> dihybridCross(String parent1, String parent2) {
    List<String> gametes1 = getGametes(parent1);
    List<String> gametes2 = getGametes(parent2);
    
    Map<String, int> genotypeCounts = {};

    for (var gamete1 in gametes1) {
      for (var gamete2 in gametes2) {
        String genotype = sortGenotype(gamete1 + gamete2);
        genotypeCounts[genotype] = (genotypeCounts[genotype] ?? 0) + 1;
      }
    }

    return genotypeCounts;
  }

  static String sortGenotype(String genotype) {
    List<String> gene1 = [genotype[0], genotype[2]]..sort();
    List<String> gene2 = [genotype[1], genotype[3]]..sort();
    return '${gene1[0]}${gene1[1]}${gene2[0]}${gene2[1]}';
  }
}