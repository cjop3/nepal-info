import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var timeManager = TimeManager()

    let nepalData: [String: [String]] = [
        "Koshi Province": ["Bhojpur", "Dhankuta", "Ilam", "Jhapa", "Khotang", "Morang", "Okhaldhunga", "Panchthar", "Sankhuwasabha", "Solukhumbu", "Sunsari", "Taplejung", "Terhathum", "Udayapur"],
        "Madhesh Province": ["Bara", "Dhanusha", "Mahottari", "Parsa", "Rautahat", "Saptari", "Sarlahi", "Siraha"],
        "Bagmati Province": ["Bhaktapur", "Chitwan", "Dhading", "Dolakha", "Kathmandu", "Kavrepalanchok (Kavre)", "Lalitpur", "Makwanpur", "Nuwakot", "Ramechhap", "Rasuwa", "Sindhuli", "Sindhupalchok"],
        "Gandaki Province": ["Baglung", "Gorkha", "Kaski", "Lamjung", "Manang", "Mustang", "Myagdi", "Nawalpur (East Nawalparasi)", "Parbat", "Syangja", "Tanahun"],
        "Lumbini Province": ["Arghakhanchi", "Banke", "Bardiya (Bardia)", "Dang Deukhuri (Dang)", "Gulmi", "Kapilvastu", "Palpa", "Pyuthan", "Rolpa", "Rupandehi", "Parasi (West Nawalparasi)", "Eastern Rukum"],
         "Karnali Province": ["Dolpa", "Humla", "Jumla", "Kalikot", "Mugu", "Salyan", "Surkhet", "Dailekh", "Jajarkot", "Western Rukum"],
         "Sudurpashchim Province": ["Achham (Accham)", "Bajhang", "Bajura", "Dadeldhura", "Darchula", "Doti", "Kailali", "Kanchanpur", "Baitadi"]
    ]

    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.94, blue: 0.94)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                HStack {
                    Text("Current Time: \(timeManager.currentTime)")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    Spacer()
                }
                .padding(.horizontal, 16)

                HStack {
                    Text("Provinces: \(nepalData.count)")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

                    Spacer()

                    Text("Districts: \(calculateTotalDistricts())")
                        .font(.headline)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                }
                .padding(.horizontal, 16)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(nepalData.sorted(by: { $0.key < $1.key }), id: \.key) { province, districts in
                            VStack(alignment: .leading) {
                                Text(province)
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 4)
                                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

                                ForEach(districts.sorted(), id: \.self) { district in
                                    Text("- \(district)")
                                        .padding(.leading, 8)
                                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }

    func calculateTotalDistricts() -> Int {
        return nepalData.values.reduce(0) { $0 + $1.count }
    }
}

class TimeManager: ObservableObject {
    @Published var currentTime: String = ""
    private var cancellable: AnyCancellable?

    init() {
        updateTime()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
            }
    }

    func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Kathmandu")
        currentTime = formatter.string(from: Date())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
