import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      ZStack() {
        ZStack() {
          ZStack() {
            VStack(spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 40, height: 40)
          .cornerRadius(9999)
          .offset(x: 0, y: 0)
        }
        .frame(width: 40, height: 40)
        .offset(x: -159, y: -0.50)
        ZStack() {
          Text("爻辞配对")
            .font(Font.custom("Song Myung", size: 18))
            .lineSpacing(28)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: -42.50, y: 0)
        }
        .frame(width: 71, height: 28)
        .offset(x: 35.50, y: -0.50)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 40, height: 40)
          .cornerRadius(9999)
          .offset(x: 159, y: -0.50)
      }
      .frame(width: 390, height: 65)
      .background(.white)
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
          )
      )
      .offset(x: 0, y: -409.50)
      ZStack() {
        ZStack() {
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 358, height: 56)
              .background(Color(red: 1, green: 1, blue: 1).opacity(0))
              .cornerRadius(12)
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0.03, green: 0.42, blue: 0.32, opacity: 0.20), radius: 6, y: 4
              )
            Text("提交答案")
              .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
              .lineSpacing(28)
              .foregroundColor(.white)
              .offset(x: 0, y: -0.50)
          }
          .frame(width: 358, height: 56)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32))
          .cornerRadius(12)
          .offset(x: 0, y: -24)
          ZStack() {
            Text("跳过此题")
              .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.medium))
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: 0, y: 0)
          }
          .frame(width: 56, height: 36)
          .offset(x: 0, y: 34)
        }
        .frame(width: 358, height: 104)
        .offset(x: 0, y: 0.50)
      }
      .frame(width: 390, height: 137)
      .background(.white)
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
          )
      )
      .offset(x: 0, y: 373.50)
      ZStack() {
        ZStack() {
          ZStack() {
            Text("当前卦象: 风天小畜")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.bold))
              .tracking(0.60)
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: 0, y: 0)
          }
          .frame(width: 132.86, height: 24)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
          .cornerRadius(9999)
          .offset(x: 0, y: -65)
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 96, height: 8)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: 0, y: -30)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 96, height: 8)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: 0, y: -18)
              ZStack() {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 44, height: 8)
                  .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                  .cornerRadius(9999)
                  .offset(x: -26, y: 0)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 44, height: 8)
                  .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                  .cornerRadius(9999)
                  .offset(x: 26, y: 0)
              }
              .frame(width: 96, height: 8)
              .offset(x: 0, y: -6)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 96, height: 8)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: 0, y: 6)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 96, height: 8)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: 0, y: 18)
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 96, height: 8)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: 0, y: 30)
            }
            .frame(width: 96, height: 68)
            .offset(x: 0, y: 8)
          }
          .frame(width: 96, height: 84)
          .offset(x: 0, y: -11)
          ZStack() {
            ZStack() {
              Text("风天小畜 的第 4 爻爻辞是？")
                .font(Font.custom("WenQuanYi Zen Hei", size: 24).weight(.bold))
                .lineSpacing(30)
                .underline()
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 297.28, height: 30)
            .offset(x: 0, y: 8)
          }
          .frame(width: 297.28, height: 46)
          .offset(x: 0, y: 54)
        }
        .frame(width: 358, height: 202)
        .offset(x: 0, y: -218)
        ZStack() {
          ZStack() {
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("A")
                    .font(Font.custom("Inter", size: 12).weight(.bold))
                    .lineSpacing(16)
                    .foregroundColor(.white)
                    .offset(x: 0, y: -0.50)
                }
                .frame(width: 24, height: 24)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .cornerRadius(9999)
                .offset(x: -135, y: 0)
                ZStack() {
                  Text("六四：有孚，血去惕出，无咎。")
                    .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
                    .lineSpacing(24)
                    .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 224, height: 24)
                .offset(x: -3, y: 0)
              }
              .frame(width: 294, height: 24)
              .offset(x: 0, y: -22)
              ZStack() {
                Text("白话：心怀诚信，能避开血光之灾，走出\n警惕不安，没有灾祸。")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 14))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.70))
                  .offset(x: 16, y: 0)
              }
              .frame(width: 294, height: 40)
              .offset(x: 0, y: 14)
            }
            .frame(width: 294, height: 68)
            .offset(x: -14, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            .offset(x: 147, y: 0)
          }
          .frame(width: 358, height: 104)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(Color(red: 0.03, green: 0.42, blue: 0.32), lineWidth: 1)
          )
          .offset(x: 0, y: -154)
          ZStack() {
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("B")
                    .font(Font.custom("Inter", size: 12).weight(.bold))
                    .lineSpacing(16)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: -0.01, y: -0.50)
                }
                .frame(width: 24, height: 24)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
                .cornerRadius(9999)
                .offset(x: -135, y: 0)
                ZStack() {
                  Text("初九：复自道，何其咎，吉。")
                    .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
                    .lineSpacing(24)
                    .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 208, height: 24)
                .offset(x: -11, y: 0)
              }
              .frame(width: 294, height: 24)
              .offset(x: 0, y: -22)
              ZStack() {
                Text("白话：返回其本道，这有什么灾祸，吉\n祥。")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 14))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 16, y: 0)
              }
              .frame(width: 294, height: 40)
              .offset(x: 0, y: 14)
            }
            .frame(width: 294, height: 68)
            .offset(x: -14, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            .offset(x: 147, y: 0)
          }
          .frame(width: 358, height: 104)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: 0, y: -38)
          ZStack() {
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("C")
                    .font(Font.custom("Inter", size: 12).weight(.bold))
                    .lineSpacing(16)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: 0, y: -0.50)
                }
                .frame(width: 24, height: 24)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
                .cornerRadius(9999)
                .offset(x: -135, y: 0)
                ZStack() {
                  Text("九二：牵复，吉。")
                    .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
                    .lineSpacing(24)
                    .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 128, height: 24)
                .offset(x: -51, y: 0)
              }
              .frame(width: 294, height: 24)
              .offset(x: 0, y: -12)
              ZStack() {
                Text("白话：拉回来，吉祥。")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 14))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 16, y: 0)
              }
              .frame(width: 294, height: 20)
              .offset(x: 0, y: 14)
            }
            .frame(width: 294, height: 48)
            .offset(x: -14, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            .offset(x: 147, y: 0)
          }
          .frame(width: 358, height: 84)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: 0, y: 68)
          ZStack() {
            ZStack() {
              ZStack() {
                ZStack() {
                  Text("D")
                    .font(Font.custom("Inter", size: 12).weight(.bold))
                    .lineSpacing(16)
                    .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                    .offset(x: 0, y: -0.50)
                }
                .frame(width: 24, height: 24)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
                .cornerRadius(9999)
                .offset(x: -135, y: 0)
                ZStack() {
                  Text("九三：舆说辐，夫妻反目。")
                    .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
                    .lineSpacing(24)
                    .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                    .offset(x: 0, y: 0)
                }
                .frame(width: 192, height: 24)
                .offset(x: -19, y: 0)
              }
              .frame(width: 294, height: 24)
              .offset(x: 0, y: -12)
              ZStack() {
                Text("白话：车轮的辐条脱落，夫妻反目成仇。")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 14))
                  .lineSpacing(20)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 16, y: 0)
              }
              .frame(width: 294, height: 20)
              .offset(x: 0, y: 14)
            }
            .frame(width: 294, height: 48)
            .offset(x: -14, y: 0)
            VStack(alignment: .leading, spacing: undefined) {

            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            .offset(x: 147, y: 0)
          }
          .frame(width: 358, height: 84)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 1
              )
          )
          .offset(x: 0, y: 164)
        }
        .frame(width: 358, height: 412)
        .offset(x: 0, y: 113)
      }
      .frame(width: 390, height: 670)
      .offset(x: 0, y: -42)
    }
    .frame(width: 390, height: 884)
    .background(Color(red: 0.96, green: 0.97, blue: 0.97));
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}