import 'package:flutter/material.dart';

class Candidatures extends StatefulWidget {
  const Candidatures({super.key});

  @override
  State<Candidatures> createState() => _CandidaturesState();
}

class _CandidaturesState extends State<Candidatures> {
  int _selectedTabIndex = 0; // Index du filtre actif
  int _selectedNavIndex = 1; // Index navigation (Candidatures)

  // Liste complète des candidatures
  final List<Map<String, dynamic>> _toutesLesCandidatures = [
    {
      "title": "Développeur Full Stack",
      "company": "TechAfrique Solutions",
      "location": "Lomé, Togo",
      "daysAgo": "Il y a 2 jours",
      "status": "En cours",
      "statusColor": Colors.blue,
      "icon": Icons.code,
      "iconBg": Colors.brown,
    },
    {
      "title": "Designer UX/UI",
      "company": "Digital Afrique",
      "location": "Abidjan, Côte d'Ivoire",
      "daysAgo": "Il y a 5 jours",
      "status": "En attente",
      "statusColor": Colors.orange,
      "icon": Icons.design_services,
      "iconBg": Colors.blue,
    },
    {
      "title": "Data Scientist",
      "company": "AfriData Analytics",
      "location": "Dakar, Sénégal",
      "daysAgo": "Il y a 1 semaine",
      "status": "Acceptée",
      "statusColor": Colors.green,
      "icon": Icons.analytics,
      "iconBg": Colors.brown,
    },
    {
      "title": "Chef de Projet Digital",
      "company": "Innovate Africa",
      "location": "Accra, Ghana",
      "daysAgo": "Il y a 2 semaines",
      "status": "Refusée",
      "statusColor": Colors.red,
      "icon": Icons.work,
      "iconBg": Colors.purple,
    },
  ];

  // Filtre les candidatures selon l'onglet sélectionné
  List<Map<String, dynamic>> get _candidaturesFiltrees {
    switch (_selectedTabIndex) {
      case 0: // Toutes
        return _toutesLesCandidatures;
      case 1: // Actives (En cours + En attente)
        return _toutesLesCandidatures
            .where((c) => c["status"] == "En cours" || c["status"] == "En attente")
            .toList();
      case 2: // Acceptées
        return _toutesLesCandidatures
            .where((c) => c["status"] == "Acceptée")
            .toList();
      case 3: // Refusées
        return _toutesLesCandidatures
            .where((c) => c["status"] == "Refusée")
            .toList();
      default:
        return _toutesLesCandidatures;
    }
  }

  // Calcule les statistiques
  int get _totalCandidatures => _toutesLesCandidatures.length;
  int get _enCours => _toutesLesCandidatures
      .where((c) => c["status"] == "En cours" || c["status"] == "En attente")
      .length;
  int get _acceptees => _toutesLesCandidatures
      .where((c) => c["status"] == "Acceptée")
      .length;
  int get _refusees => _toutesLesCandidatures
      .where((c) => c["status"] == "Refusée")
      .length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mes Candidatures",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Suivez l'état de vos candidatures",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        toolbarHeight: 130,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          // Section des statistiques et filtres
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Ligne 1 : Total et En cours
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "Total",
                        "$_totalCandidatures",
                        Colors.blue.shade50,
                        Colors.blue,
                        Icons.description_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        "En cours",
                        "$_enCours",
                        Colors.yellow.shade50,
                        Colors.orange,
                        Icons.schedule_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Ligne 2 : Acceptées et Refusées
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "Acceptées",
                        "$_acceptees",
                        Colors.green.shade50,
                        Colors.green,
                        Icons.check_circle_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        "Refusées",
                        "$_refusees",
                        Colors.red.shade50,
                        Colors.red,
                        Icons.cancel_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Barre de filtres
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTabButton("Toutes", 0),
                      _buildTabButton("Actives", 1),
                      _buildTabButton("Acceptées", 2),
                      _buildTabButton("Refusées", 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Liste des candidatures filtrées
          Expanded(
            child: _candidaturesFiltrees.isEmpty
                ? Center(
                    child: Text(
                      "Aucune candidature dans cette catégorie",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _candidaturesFiltrees.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final candidature = _candidaturesFiltrees[index];
                      return _buildCandidatureCard(
                        title: candidature["title"],
                        company: candidature["company"],
                        location: candidature["location"],
                        daysAgo: candidature["daysAgo"],
                        status: candidature["status"],
                        statusColor: candidature["statusColor"],
                        icon: candidature["icon"],
                        iconBg: candidature["iconBg"],
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: "Candidatures",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: "Favoris",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  // Widget pour une carte de statistique
  Widget _buildStatCard(
    String title,
    String value,
    Color bgColor,
    Color iconColor,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: iconColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 79, 85, 101),
                ),
              ),
              SizedBox(height: 6),
              Text(value, style: TextStyle(fontSize: 16, color: iconColor)),
            ],
          ),
          Icon(icon, color: iconColor, size: 30),
        ],
      ),
    );
  }

  // Widget pour un bouton de filtre
  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedTabIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey.shade200,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          minimumSize: Size(70, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  // Widget pour une carte de candidature
  Widget _buildCandidatureCard({
    required String title,
    required String company,
    required String location,
    required String daysAgo,
    required String status,
    required Color statusColor,
    required IconData icon,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Icône de la candidature
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          // Informations de la candidature
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  daysAgo,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Badge de statut
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}