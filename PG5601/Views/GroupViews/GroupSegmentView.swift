import SwiftUI

struct GroupSegmentView: View {

    var text: String
	var groupType: String

    init(_ text: String, _ groupType: String) {
        self.text = text
        self.groupType = groupType
    }

    var body: some View {
        VStack(alignment: .leading) {
			NavigationLink(destination: ListGroupView(text, groupType)) {
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

struct GroupSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSegmentView(text, "")
    }
}
