part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            const Icon(Icons.map, color: Color.fromARGB(255, 153, 49, 209)),
            const SizedBox(width: 8),
            const Text(
              "Province Data",
              style: TextStyle(
                color: Color.fromARGB(255, 153, 49, 209),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(builder: (context, value, _) {
            switch (value.provinceList.status) {
              case Status.loading:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(color: Color.fromARGB(255, 153, 49, 209)),
                      SizedBox(height: 16),
                      Text(
                        "Loading data...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              case Status.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48, color: Colors.redAccent),
                      SizedBox(height: 16),
                      Text(
                        value.provinceList.message.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              case Status.completed:
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 8),
                  itemCount: value.provinceList.data?.length,
                  itemBuilder: (context, index) {
                    return CardProvince(
                      value.provinceList.data!.elementAt(index),
                    );
                  },
                );
              default:
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
