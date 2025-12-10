import 'package:flutter/material.dart';

/// Modèle représentant une candidature
class Candidature {
  final String poste;
  final String entreprise;
  final String ville;
  final String pays;
  final String delai;
  final StatutCandidature statut;
  final String imageUrl;

  Candidature({
    required this.poste,
    required this.entreprise,
    required this.ville,
    required this.pays,
    required this.delai,
    required this.statut,
    required this.imageUrl,
  });
}
