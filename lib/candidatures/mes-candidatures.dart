import 'package:flutter/material.dart';

// ============================================================================
// MODÈLES DE DONNÉES
// ============================================================================

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

/// Énumération des différents statuts possibles
enum StatutCandidature {
  enCours,
  enAttente,
  acceptee,
  refusee,
}

// ============================================================================
// ÉNUMÉRATION DES FILTRES
// ============================================================================

enum FiltreCandidature {
  toutes,
  actives,
  acceptees,
  refusees,
}

// ============================================================================
// PAGE PRINCIPALE
// ============================================================================

/// Page principale affichant la liste des candidatures
/// 
/// Widget StatefulWidget : Widget avec état modifiable
/// - Utilisé quand l'interface doit changer en réponse aux interactions
/// - Sépare le widget (immuable) de son état (mutable)
class MesCandidaturesPage extends StatefulWidget {
  const MesCandidaturesPage({Key? key}) : super(key: key);

  @override
  State<MesCandidaturesPage> createState() => _MesCandidaturesPageState();
}

/// État de la page (contient les données qui peuvent changer)
class _MesCandidaturesPageState extends State<MesCandidaturesPage> {
  // Variable d'état pour suivre le filtre sélectionné
  FiltreCandidature _filtreActif = FiltreCandidature.toutes;

  // Données de toutes les candidatures
  final List<Candidature> _toutesLesCandidatures = [
    Candidature(
      poste: 'Développeur Full Stack',
      entreprise: 'TechAfrique Solutions',
      ville: 'Lomé',
      pays: 'Togo',
      delai: 'Il y a 2 jours',
      statut: StatutCandidature.enCours,
      imageUrl: '🏢',
    ),
    Candidature(
      poste: 'Designer UX/UI',
      entreprise: 'Digital Afrique',
      ville: 'Abidjan',
      pays: 'Côte d\'Ivoire',
      delai: 'Il y a 5 jours',
      statut: StatutCandidature.enAttente,
      imageUrl: '🎨',
    ),
    Candidature(
      poste: 'Data Scientist',
      entreprise: 'AfriData Analytics',
      ville: 'Accra',
      pays: 'Ghana',
      delai: 'Il y a 1 semaine',
      statut: StatutCandidature.acceptee,
      imageUrl: '📊',
    ),
    Candidature(
      poste: 'Chef de Projet',
      entreprise: 'Innov\'Togo',
      ville: 'Sokodé',
      pays: 'Togo',
      delai: 'Il y a 2 semaines',
      statut: StatutCandidature.refusee,
      imageUrl: '🚀',
    ),
  ];

  /// Méthode pour filtrer les candidatures selon le filtre actif
  List<Candidature> _getCandidaturesFiltrees() {
    switch (_filtreActif) {
      case FiltreCandidature.toutes:
        return _toutesLesCandidatures;
      
      case FiltreCandidature.actives:
        // Retourne uniquement les candidatures "en cours" ou "en attente"
        return _toutesLesCandidatures.where((c) => 
          c.statut == StatutCandidature.enCours || 
          c.statut == StatutCandidature.enAttente
        ).toList();
      
      case FiltreCandidature.acceptees:
        return _toutesLesCandidatures.where((c) => 
          c.statut == StatutCandidature.acceptee
        ).toList();
      
      case FiltreCandidature.refusees:
        return _toutesLesCandidatures.where((c) => 
          c.statut == StatutCandidature.refusee
        ).toList();
    }
  }

  /// Méthode pour calculer les statistiques
  Map<String, int> _getStatistiques() {
    return {
      'total': _toutesLesCandidatures.length,
      'enCours': _toutesLesCandidatures.where((c) => 
        c.statut == StatutCandidature.enCours || 
        c.statut == StatutCandidature.enAttente
      ).length,
      'acceptees': _toutesLesCandidatures.where((c) => 
        c.statut == StatutCandidature.acceptee
      ).length,
      'refusees': _toutesLesCandidatures.where((c) => 
        c.statut == StatutCandidature.refusee
      ).length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Construction de l'AppBar (barre d'en-tête)
  /// 
  /// Widget AppBar : Barre d'en-tête Material Design
  /// - backgroundColor : Couleur de fond
  /// - elevation : Ombre portée (0 = pas d'ombre)
  /// - title : Widget affiché comme titre
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue[700],
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mes Candidatures',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Suivez l\'état de vos candidatures',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// Construction du corps de la page
  /// 
  /// Widget Column : Organise les enfants verticalement
  /// - children : Liste des widgets enfants
  Widget _buildBody() {
    return Column(
      children: [
        // Cartes de statistiques
        _buildStatistiquesSection(),
        
        // Onglets de filtrage
        _buildTabsSection(),
        
        // Liste des candidatures (scrollable)
        Expanded(
          child: _buildListeCandidatures(),
        ),
      ],
    );
  }

  /// Section des statistiques (4 cartes en haut)
  /// 
  /// Widget Padding : Ajoute des marges internes
  /// - padding : EdgeInsets définit les espacements
  Widget _buildStatistiquesSection() {
    final stats = _getStatistiques();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Première ligne : Total et En cours
          Row(
            children: [
              Expanded(
                child: CarteStatistique(
                  titre: 'Total',
                  valeur: '${stats['total']}',
                  couleur: Colors.blue[50]!,
                  icone: Icons.description,
                  couleurIcone: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CarteStatistique(
                  titre: 'En cours',
                  valeur: '${stats['enCours']}',
                  couleur: Colors.yellow[50]!,
                  icone: Icons.schedule,
                  couleurIcone: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Deuxième ligne : Acceptées et Refusées
          Row(
            children: [
              Expanded(
                child: CarteStatistique(
                  titre: 'Acceptées',
                  valeur: '${stats['acceptees']}',
                  couleur: Colors.green[50]!,
                  icone: Icons.check_circle,
                  couleurIcone: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CarteStatistique(
                  titre: 'Refusées',
                  valeur: '${stats['refusees']}',
                  couleur: Colors.red[50]!,
                  icone: Icons.cancel,
                  couleurIcone: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section des onglets de filtrage
  /// 
  /// Widget Container : Boîte personnalisable
  /// - decoration : BoxDecoration pour styles (couleur, bordures, ombres)
  Widget _buildTabsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OngletFiltre(
              titre: 'Toutes',
              estActif: _filtreActif == FiltreCandidature.toutes,
              onTap: () {
                // setState() : Indique à Flutter de reconstruire le widget
                // C'est comme dire "j'ai changé quelque chose, mets à jour l'écran"
                setState(() {
                  _filtreActif = FiltreCandidature.toutes;
                });
              },
            ),
          ),
          Expanded(
            child: OngletFiltre(
              titre: 'Actives',
              estActif: _filtreActif == FiltreCandidature.actives,
              onTap: () {
                setState(() {
                  _filtreActif = FiltreCandidature.actives;
                });
              },
            ),
          ),
          Expanded(
            child: OngletFiltre(
              titre: 'Acceptées',
              estActif: _filtreActif == FiltreCandidature.acceptees,
              onTap: () {
                setState(() {
                  _filtreActif = FiltreCandidature.acceptees;
                });
              },
            ),
          ),
          Expanded(
            child: OngletFiltre(
              titre: 'Refusées',
              estActif: _filtreActif == FiltreCandidature.refusees,
              onTap: () {
                setState(() {
                  _filtreActif = FiltreCandidature.refusees;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Liste scrollable des candidatures
  /// 
  /// Widget ListView.builder : Liste optimisée pour grandes données
  /// - itemCount : Nombre d'éléments
  /// - itemBuilder : Fonction qui construit chaque élément
  Widget _buildListeCandidatures() {
    // Récupère les candidatures filtrées selon le filtre actif
    final candidaturesFiltrees = _getCandidaturesFiltrees();

    // Si aucune candidature ne correspond au filtre
    if (candidaturesFiltrees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune candidature',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Il n\'y a pas de candidatures dans cette catégorie',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: candidaturesFiltrees.length,
      itemBuilder: (context, index) {
        return CarteCandidature(candidature: candidaturesFiltrees[index]);
      },
    );
  }

  /// Barre de navigation inférieure
  /// 
  /// Widget BottomNavigationBar : Barre de navigation Material Design
  /// - items : Liste des onglets
  /// - currentIndex : Index de l'onglet sélectionné
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1, // Candidatures est sélectionné
      selectedItemColor: Colors.blue[700],
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Candidatures',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoris',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profil',
        ),
      ],
    );
  }
}

// ============================================================================
// WIDGETS RÉUTILISABLES
// ============================================================================

/// Widget pour afficher une carte de statistique
/// 
/// Widget StatelessWidget : Widget immuable sans état
/// - const constructor : Optimisation des performances
class CarteStatistique extends StatelessWidget {
  final String titre;
  final String valeur;
  final Color couleur;
  final IconData icone;
  final Color couleurIcone;

  const CarteStatistique({
    Key? key,
    required this.titre,
    required this.valeur,
    required this.couleur,
    required this.icone,
    required this.couleurIcone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: couleur,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: couleurIcone.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titre,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              Icon(
                icone,
                color: couleurIcone,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            valeur,
            style: TextStyle(
              color: couleurIcone,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget pour un onglet de filtre
/// 
/// Widget GestureDetector : Détecte les gestes tactiles
/// - onTap : Fonction appelée quand on tape sur le widget
class OngletFiltre extends StatelessWidget {
  final String titre;
  final bool estActif;
  final VoidCallback onTap; // Fonction à exécuter lors du tap

  const OngletFiltre({
    Key? key,
    required this.titre,
    required this.estActif,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Appelle la fonction quand on tape
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: estActif ? Colors.blue[700] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          titre,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: estActif ? Colors.white : Colors.grey[600],
            fontWeight: estActif ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

/// Widget pour afficher une carte de candidature
/// 
/// Widget Card : Carte Material Design avec élévation
/// - elevation : Hauteur de l'ombre
/// - shape : Forme avec bordures arrondies
class CarteCandidature extends StatelessWidget {
  final Candidature candidature;

  const CarteCandidature({
    Key? key,
    required this.candidature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icône de l'entreprise
            _buildIconeEntreprise(),
            const SizedBox(width: 12),
            
            // Informations de la candidature
            Expanded(
              child: _buildInformations(),
            ),
            
            // Badge de statut
            _buildBadgeStatut(),
          ],
        ),
      ),
    );
  }

  /// Icône représentant l'entreprise
  Widget _buildIconeEntreprise() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.brown[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          candidature.imageUrl,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  /// Informations textuelles de la candidature
  Widget _buildInformations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icône et titre du poste
        Row(
          children: [
            Icon(Icons.description, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                candidature.poste,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        
        // Nom de l'entreprise
        Text(
          candidature.entreprise,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        
        // Localisation
        Row(
          children: [
            Icon(Icons.location_on, size: 14, color: Colors.grey[500]),
            const SizedBox(width: 4),
            Text(
              '${candidature.ville}, ${candidature.pays}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        
        // Délai
        Text(
          candidature.delai,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  /// Badge indiquant le statut de la candidature
  Widget _buildBadgeStatut() {
    // Détermine le texte et les couleurs selon le statut
    String texte;
    Color couleurFond;
    Color couleurTexte;

    switch (candidature.statut) {
      case StatutCandidature.enCours:
        texte = 'En cours';
        couleurFond = Colors.blue;
        couleurTexte = Colors.white;
        break;
      case StatutCandidature.enAttente:
        texte = 'En attente';
        couleurFond = Colors.orange;
        couleurTexte = Colors.white;
        break;
      case StatutCandidature.acceptee:
        texte = 'Acceptée';
        couleurFond = Colors.green;
        couleurTexte = Colors.white;
        break;
      case StatutCandidature.refusee:
        texte = 'Refusée';
        couleurFond = Colors.red;
        couleurTexte = Colors.white;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: couleurFond,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texte,
        style: TextStyle(
          color: couleurTexte,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


