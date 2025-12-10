import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Joblink",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 0, 19, 233),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section bleue avec slogan
            Container(
              color: const Color.fromARGB(255, 0, 19, 233),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trouvez votre emploi idéal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Des milliers d'opportunités vous attendent",
                    style: TextStyle(
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.9,
                      ), // Remplace withOpacity
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Filtres
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip("Tout", true),
                    SizedBox(width: 8),
                    _buildFilterChip("CDI", false),
                    SizedBox(width: 8),
                    _buildFilterChip("CDD", false),
                    SizedBox(width: 8),
                    _buildFilterChip("Stage", false),
                    SizedBox(width: 8),
                    _buildFilterChip("Plus de filtres", false, isMore: true),
                  ],
                ),
              ),
            ),

            // Contenu principal avec padding
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Compteur d'offres
                  Text(
                    "6 offres disponibles",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(33, 33, 33, 1), // Gris foncé
                    ),
                  ),
                  SizedBox(height: 16),

                  // Liste des cartes
                  _buildJobCard(
                    title: "Développeur Full Stack",
                    company: "Technétique Solutions",
                    match: 90,
                    location: "Lomé, Togo",
                    contract: "CDI",
                    salary: "2.5M - 4M FCFA",
                    timeAgo: "Il y a 2 jours",
                    isNew: true,
                    imageUrl:
                        "https://ui-avatars.com/api/?name=TS&background=007bff&color=fff&size=150",
                  ),
                  SizedBox(height: 16),
                  _buildJobCard(
                    title: "Designer UX/UI",
                    company: "Digital Afrique",
                    match: 88,
                    location: "Abidjan, Côte d'Ivoire",
                    contract: "CDI",
                    salary: "2M - 3M FCFA",
                    timeAgo: "Il y a 3 jours",
                    isNew: false,
                    imageUrl:
                        "https://ui-avatars.com/api/?name=DA&background=28a745&color=fff&size=150",
                  ),
                  SizedBox(height: 16),
                  _buildJobCard(
                    title: "Chef de Projet Digital",
                    company: "Innov'Togo",
                    match: 75,
                    location: "Kara, Togo",
                    contract: "CDD",
                    salary: "À discuter",
                    timeAgo: "Il y a 5 jours",
                    isNew: false,
                    imageUrl:
                        "https://ui-avatars.com/api/?name=IT&background=ff6b35&color=fff&size=150",
                  ),
                  SizedBox(height: 16),
                  _buildJobCard(
                    title: "Chef communication",
                    company: "COol",
                    match: 80,
                    location: "Kigali, Rwanda",
                    contract: "CDD",
                    salary: "3000\$ - 5000\$",
                    timeAgo: "Il y a 1 jours",
                    isNew: true,
                    imageUrl:
                        "https://ui-avatars.com/api/?name=CC&background=ff3b35&color=fff&size=150",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: "Accueil", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: "Candidature",
            icon: Icon(Icons.description),
          ),
          BottomNavigationBarItem(label: "Favoris", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
            label: "Profil",
            icon: Icon(Icons.person_outlined),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 0, 19, 233),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }

  // Fonction pour créer un filtre
  Widget _buildFilterChip(String text, bool isSelected, {bool isMore = false}) {
    if (isMore) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(224, 224, 224, 1)),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Text(text, style: TextStyle(fontSize: 14)),
            SizedBox(width: 4),
            Icon(Icons.filter_list, size: 16),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Color.fromARGB(255, 0, 19, 233)
            : Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Color.fromRGBO(66, 66, 66, 1),
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  // Fonction pour créer une carte d'emploi
  Widget _buildJobCard({
    required String title,
    required String company,
    required int match,
    required String location,
    required String contract,
    required String salary,
    required String timeAgo,
    bool isNew = false,
    String? imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(158, 158, 158, 0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Première ligne : Image + Titre + Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image à gauche
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(250, 250, 250, 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageUrl != null
                        ? Image.network(imageUrl, fit: BoxFit.cover)
                        : Icon(
                            Icons.business,
                            color: Color.fromRGBO(189, 189, 189, 1),
                            size: 24,
                          ),
                  ),
                ),

                SizedBox(width: 12),

                // Titre et entreprise
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(33, 33, 33, 1),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        company,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                      ),
                    ],
                  ),
                ),

                // Badge match à droite
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: match > 85
                        ? Color.fromRGBO(232, 245, 233, 1)
                        : match > 70
                        ? Color.fromRGBO(255, 243, 224, 1)
                        : Color.fromRGBO(255, 235, 238, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "$match% match",
                    style: TextStyle(
                      color: match > 85
                          ? Color.fromRGBO(46, 125, 50, 1)
                          : match > 70
                          ? Color.fromRGBO(245, 124, 0, 1)
                          : Color.fromRGBO(211, 47, 47, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Deuxième ligne : Localisation et type de contrat
            Row(
              children: [
                _buildInfoItem(Icons.location_on, location),
                SizedBox(width: 16),
                _buildInfoItem(Icons.business_center, contract),
              ],
            ),

            SizedBox(height: 8),

            // Troisième ligne : Salaire
            _buildInfoItem(Icons.attach_money, salary),

            SizedBox(height: 16),

            // Quatrième ligne : Date et badge "Nouveau"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Color.fromRGBO(158, 158, 158, 1),
                    fontSize: 13,
                  ),
                ),

                if (isNew)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(227, 242, 253, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.new_releases,
                          size: 12,
                          color: Color.fromRGBO(21, 101, 192, 1),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Nouveau",
                          style: TextStyle(
                            color: Color.fromRGBO(21, 101, 192, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fonction utilitaire pour créer un élément d'info avec icône
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Color.fromRGBO(158, 158, 158, 1)),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: Color.fromRGBO(97, 97, 97, 1), fontSize: 14),
        ),
      ],
    );
  }
}
