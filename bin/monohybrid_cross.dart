class MonohybridCross {
  static Map<String, int> monohybridCross(String parent1, String parent2) {
    List<String> genes1 = [parent1[0], parent1[1]];
    List<String> genes2 = [parent2[0], parent2[1]];
    Map<String, int> genotypeCounts = {};

    for (var gene1 in genes1) {
      for (var gene2 in genes2) {
        String genotype = gene1 + gene2;
        genotypeCounts[genotype] = (genotypeCounts[genotype] ?? 0) + 1;
      }
    }

    Map<String, int> sortedGenotypeCounts = {};
    genotypeCounts.forEach((genotype, count) {
      List<String> sortedGenotype = genotype.split('')..sort();
      String sortedGenotypeStr = sortedGenotype.join();
      sortedGenotypeCounts[sortedGenotypeStr] = (sortedGenotypeCounts[sortedGenotypeStr] ?? 0) + count;
    });

    return sortedGenotypeCounts;
  }
}
