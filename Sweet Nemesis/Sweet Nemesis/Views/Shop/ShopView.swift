import SwiftUI

struct ShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: ShopViewModel
    
    var body: some View {
        ZStack {
            
            
            ZStack {
                Image(.shopBg)
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Shop")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 92:48))
                            .textCase(.uppercase)
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        
                        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 10:5) {
                            HStack {
                                Spacer()
                                Text("Sweets")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            
                            sweetItemView(item: shopVM.sweets[0], btnTapped: {
                                if shopVM.boughtItems.contains(shopVM.sweets[0].name) {
                                    shopVM.currentSweet = shopVM.sweets[0]
                                } else {
                                    if UserCoins.shared.coins >= shopVM.sweets[0].price {
                                        shopVM.boughtItems.append(shopVM.sweets[0].name)
                                        UserCoins.shared.minusUserCoins(for: shopVM.sweets[0].price)
                                    }

                                }
                            })
                            HStack {
                                sweetItemView(item: shopVM.sweets[1], btnTapped: {
                                    if shopVM.boughtItems.contains(shopVM.sweets[1].name) {
                                        shopVM.currentSweet = shopVM.sweets[1]
                                    } else {
                                        if UserCoins.shared.coins >= shopVM.sweets[1].price {
                                            shopVM.boughtItems.append(shopVM.sweets[1].name)
                                            UserCoins.shared.minusUserCoins(for: shopVM.sweets[1].price)
                                        }

                                    }
                                })
                                sweetItemView(item: shopVM.sweets[2], btnTapped: {
                                    if shopVM.boughtItems.contains(shopVM.sweets[2].name) {
                                        shopVM.currentSweet = shopVM.sweets[2]
                                    } else {
                                        if UserCoins.shared.coins >= shopVM.sweets[2].price {
                                            shopVM.boughtItems.append(shopVM.sweets[2].name)
                                            UserCoins.shared.minusUserCoins(for: shopVM.sweets[2].price)
                                        }

                                    }
                                })
                            }
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .foregroundStyle(.white)
                            .frame(width: DeviceInfo.shared.deviceType == .pad ? 4:2)
                        
                        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 10:5) {
                            HStack {
                                Spacer()
                                Text("Obstacles")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.white)
                            Spacer()
                            }
                            
                            obstacleItemView(item: shopVM.obstacles[0], btnTapped: {
                                if shopVM.boughtItems.contains(shopVM.obstacles[0].name) {
                                    shopVM.currentObstacle = shopVM.obstacles[0]
                                } else {
                                    if UserCoins.shared.coins >= shopVM.obstacles[0].price {
                                        shopVM.boughtItems.append(shopVM.obstacles[0].name)
                                        UserCoins.shared.minusUserCoins(for: shopVM.obstacles[0].price)
                                    }

                                }
                            })
                            
                            HStack {
                                obstacleItemView(item: shopVM.obstacles[1], btnTapped: {
                                    if shopVM.boughtItems.contains(shopVM.obstacles[1].name) {
                                        shopVM.currentObstacle = shopVM.obstacles[1]
                                    } else {
                                        if UserCoins.shared.coins >= shopVM.obstacles[1].price {
                                            shopVM.boughtItems.append(shopVM.obstacles[1].name)
                                            UserCoins.shared.minusUserCoins(for: shopVM.obstacles[1].price)
                                        }

                                    }
                                })
                                
                                obstacleItemView(item: shopVM.obstacles[2], btnTapped: {
                                    if shopVM.boughtItems.contains(shopVM.obstacles[2].name) {
                                        shopVM.currentObstacle = shopVM.obstacles[2]
                                    } else {
                                        if UserCoins.shared.coins >= shopVM.obstacles[2].price {
                                            shopVM.boughtItems.append(shopVM.obstacles[2].name)
                                            UserCoins.shared.minusUserCoins(for: shopVM.obstacles[2].price)
                                        }

                                    }
                                })
                            }
                            Spacer()
                        }
                        
                        
                    }
                    
                    
                }.padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 64:32).padding(.top)
            }.frame(width: DeviceInfo.shared.deviceType == .pad ? 1100:555,height: DeviceInfo.shared.deviceType == .pad ? 700:352)
            
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.backSN)
                                .resizable()
                                .scaledToFit()
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                    
                    CoinsBg()
                    
                }.padding([.leading, .top])
                
                Spacer()
            }
        }.background(
            Image(.bgSN)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 4)
            
        )
    }
    
    @ViewBuilder func sweetItemView(item: Item, btnTapped: @escaping () -> ()) -> some View {
        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 8:4) {
            Image(item.design)
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
            
            Text(item.name)
                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            
            Button {
                btnTapped()
            } label: {
                if shopVM.boughtItems.contains(item.name) {
                    ZStack {
                        Image(shopVM.currentSweet?.name == item.name ? .selectedBg: .selectBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 50:25)
                        Text(shopVM.currentSweet?.name == item.name ? "Selected": "Choose")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 24:12))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                    }
                    
                } else {
                    ZStack {
                        Image(UserCoins.shared.coins < item.price ? .noMoneyBg: .priceBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 50:25)
                        
                        Text("\(item.price)")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                            .foregroundStyle(.white)
                            .offset(x: DeviceInfo.shared.deviceType == .pad ? 30:15, y: DeviceInfo.shared.deviceType == .pad ? -6:-3)
                        
                    }
                }
            }
        }
        .padding(DeviceInfo.shared.deviceType == .pad ? 4:2)
        .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 10:5)
        .background(
            Color.mainPurple
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: DeviceInfo.shared.deviceType == .pad ? 2:1)
        )
    }
    
    @ViewBuilder func obstacleItemView(item: Item, btnTapped: @escaping () -> ()) -> some View {
        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 8:4) {
            Image(item.design)
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
            
            Text(item.name)
                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                .foregroundStyle(.white)
                .textCase(.uppercase)
            
            Button {
                btnTapped()
            } label: {
                if shopVM.boughtItems.contains(item.name) {
                    ZStack {
                        Image(shopVM.currentObstacle?.name == item.name ? .selectedBg: .selectBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 50:25)
                        Text(shopVM.currentObstacle?.name == item.name ? "Selected": "Select")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 24:12))
                            .foregroundStyle(.white)
                            .textCase(.uppercase)
                    }
                    
                } else {
                    ZStack {
                        Image(UserCoins.shared.coins < item.price ? .noMoneyBg: .priceBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 50:25)
                        
                        Text("\(item.price)")
                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 32:16))
                            .foregroundStyle(.white)
                            .offset(x: DeviceInfo.shared.deviceType == .pad ? 30:15, y: DeviceInfo.shared.deviceType == .pad ? -6:-3)
                        
                    }
                }
            }
        }
        .padding(DeviceInfo.shared.deviceType == .pad ? 4:2)
        .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 10:5)
        .background(
            Color.mainPurple
        )
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: DeviceInfo.shared.deviceType == .pad ? 2:1)
        )
    }
}

#Preview {
    ShopView(shopVM: ShopViewModel())
}
