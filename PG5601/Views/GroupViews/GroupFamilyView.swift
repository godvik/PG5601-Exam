import SwiftUI

struct GroupFamilyView: View {

    var text: String

    init(_ text: String) {
        self.text = text
    }


    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: ListFamilyView(text)) {
                HStack {
                    Text(text)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 170, height: 100)
                            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.white)
                                    .shadow(radius: 1))
                }
            }
        }
    }
}

struct GroupFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        GroupFamilyView(text)
    }
}
