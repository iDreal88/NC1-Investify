import SwiftUI

struct InvestmentCalculator: View {
    
    //  Amount
    @State private var initialInvestment_1 = ""
    @State private var interestRate_1 = ""
    @State private var yearsInvested_1 = ""
    @State private var totalAmount_1 = 0.0
    
    // Rate
    @State private var initialInvestment_2 = ""
    @State private var interestRate_2: Double = 0.0
    @State private var yearsInvested_2 = ""
    @State private var totalAmount_2 = ""
   
    @State private var selectedPicker = 0
    let picker = ["Total Amount", "Interest Rate"]
    
    // Amount
    func calculateTotal() {
        guard
            let initialInvestment_1 = Double(initialInvestment_1),
            let interestRate_1 = Double(interestRate_1),
            let yearsInvested_1 = Double(yearsInvested_1)
                else {
            return
        }
        
        let interestDecimal_1 = interestRate_1 / 100
        let totalAmount_1 = initialInvestment_1 * pow(1 + interestDecimal_1, yearsInvested_1)
        self.totalAmount_1 = totalAmount_1
    }
    
    // Rate
    func calculateRate(){
        guard
            let totalAmount_2 = Double(self.totalAmount_2),
            let initialInvestment_2 = Double(self.initialInvestment_2),
            let yearsInvested_2 = Double(self.yearsInvested_2) else {
            return
        }
        
        let interestRate_2 =  ((totalAmount_2 / initialInvestment_2 - 1) / yearsInvested_2) * 100
        self.interestRate_2 = interestRate_2
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $selectedPicker, label: Text("picker")) {
                    ForEach(0..<picker.count) { index in
                        Text(picker[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .navigationTitle("Investment Calculator")
            }
            
            
            switch selectedPicker {
            case 0:
                Form {
                    Section(header: Text("Initial Investment")) {
                        HStack{
                            Image(systemName: "dollarsign")
                                .foregroundStyle(.tertiary)
                            TextField("Amount", text: $initialInvestment_1)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Interest Rate")) {
                        HStack{
                            Image(systemName: "percent")
                                .foregroundStyle(.tertiary)
                            TextField("Percent", text: $interestRate_1)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Years Invested")) {
                        HStack{
                            Image(systemName: "calendar.badge.clock")
                                .foregroundStyle(.tertiary)
                            TextField("Years", text: $yearsInvested_1)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Total Amount")) {
                        Text("$ \(totalAmount_1, specifier: "%.2f")")
                    }
                    
                    Button(action: calculateTotal) {
                        Text("Calculate")
                    }
                    .frame(maxWidth: .infinity)
                }
                
            case 1:
                Form {
                    Section(header: Text("Initial Investment")) {
                        HStack{
                            Image(systemName: "dollarsign")
                                .foregroundStyle(.tertiary)
                            TextField("Amount", text: $initialInvestment_2)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Total Amount")) {
                        HStack{
                            Image(systemName: "equal.square")
                                .foregroundStyle(.tertiary)
                            TextField("Total", text: $totalAmount_2)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Years Invested")) {
                        HStack{
                            Image(systemName: "calendar.badge.clock")
                                .foregroundStyle(.tertiary)
                            TextField("Years", text: $yearsInvested_2)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    Section(header: Text("Interest Rate")) {
                        Text(" \(interestRate_2, specifier: "%.2f") %")
                    }
                    
                Section {
                    Button {
                        calculateRate()
                    }
                label: {
                    Text("Calculate")
                        .frame(maxWidth: .infinity)
                }
            }
        }
            default:
                Text("Error.")
            }
        }
   
        }
    }

struct InvestmentCalculator_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentCalculator()
    }
}
