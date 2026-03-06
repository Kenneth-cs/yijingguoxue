import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Text("开启每日挑战")
                .font(Font.custom("WenQuanYi Zen Hei", size: 24).weight(.black))
                .lineSpacing(30)
                .foregroundColor(.white)
                .offset(x: -55.80, y: 0)
            }
            .frame(width: 252, height: 30)
            .offset(x: 0, y: -12)
            ZStack() {
              Text("通过趣味练习巩固易经知识，提升感悟。")
                .font(Font.custom("WenQuanYi Zen Hei", size: 14))
                .lineSpacing(20)
                .foregroundColor(Color(red: 1, green: 1, blue: 1).opacity(0.90))
                .offset(x: 0, y: 0)
            }
            .frame(width: 252, height: 20)
            .offset(x: 0, y: 17)
          }
          .frame(width: 252, height: 54)
          .offset(x: -29, y: -2.31)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 104, height: 40)
              .background(Color(red: 1, green: 1, blue: 1).opacity(0))
              .cornerRadius(8)
              .offset(x: 0, y: 0)
              .shadow(
                color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 6, y: 4
              )
            Text("开始挑战")
              .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.bold))
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: 0, y: -0.50)
          }
          .frame(width: 104, height: 40)
          .background(.white)
          .cornerRadius(8)
          .offset(x: -103, y: 56.69)
        }
        .frame(width: 358, height: 201.38)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
        .cornerRadius(12)
        .offset(x: 0, y: 0)
      }
      .frame(width: 390, height: 233.38)
      .offset(x: 0, y: -413.50)
      ZStack() {
        ZStack() {
          Text("专项练习")
            .font(Font.custom("WenQuanYi Zen Hei", size: 20).weight(.bold))
            .lineSpacing(28)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: 0, y: 0)
        }
        .frame(width: 358, height: 28)
        .offset(x: 0, y: 4)
      }
      .frame(width: 390, height: 52)
      .offset(x: 0, y: -270.81)
      ZStack() {
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 169, height: 169)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
            .offset(x: 0, y: 0)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 40, height: 40)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
            .cornerRadius(8)
            .offset(x: -48.50, y: -28)
            ZStack() {
              Text("认卦游戏")
                .font(Font.custom("Song Myung", size: 16))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -36.50, y: 0)
            }
            .frame(width: 137, height: 24)
            .offset(x: 0, y: 16)
            ZStack() {
              Text("识别六十四卦象")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -26.50, y: 0)
            }
            .frame(width: 137, height: 16)
            .offset(x: 0, y: 40)
          }
          .frame(width: 137, height: 96)
          .offset(x: 0, y: 20.50)
        }
        .frame(width: 171, height: 171)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: -93.50, y: -93.50)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 169, height: 169)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
            .offset(x: 0, y: 0)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 40, height: 40)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
            .cornerRadius(8)
            .offset(x: -48.50, y: -28)
            ZStack() {
              Text("知识问答")
                .font(Font.custom("Song Myung", size: 16))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -36.50, y: 0)
            }
            .frame(width: 137, height: 24)
            .offset(x: 0, y: 16)
            ZStack() {
              Text("经传理论考核")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -32.50, y: 0)
            }
            .frame(width: 137, height: 16)
            .offset(x: 0, y: 40)
          }
          .frame(width: 137, height: 96)
          .offset(x: 0, y: 20.50)
        }
        .frame(width: 171, height: 171)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 93.50, y: -93.50)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 169, height: 169)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
            .offset(x: 0, y: 0)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 40, height: 40)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
            .cornerRadius(8)
            .offset(x: -48.50, y: -28)
            ZStack() {
              Text("卦象识别")
                .font(Font.custom("Song Myung", size: 16))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -36.50, y: 0)
            }
            .frame(width: 137, height: 24)
            .offset(x: 0, y: 16)
            ZStack() {
              Text("快速分辨阴阳爻")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -26.50, y: 0)
            }
            .frame(width: 137, height: 16)
            .offset(x: 0, y: 40)
          }
          .frame(width: 137, height: 96)
          .offset(x: 0, y: 20.50)
        }
        .frame(width: 171, height: 171)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: -93.50, y: 93.50)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 169, height: 169)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
            .offset(x: 0, y: 0)
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: 0, y: 0)
            }
            .frame(width: 40, height: 40)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
            .cornerRadius(8)
            .offset(x: -48.50, y: -28)
            ZStack() {
              Text("爻辞匹对")
                .font(Font.custom("Song Myung", size: 16))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -36.50, y: 0)
            }
            .frame(width: 137, height: 24)
            .offset(x: 0, y: 16)
            ZStack() {
              Text("对应位阶与涵义")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -26.50, y: 0)
            }
            .frame(width: 137, height: 16)
            .offset(x: 0, y: 40)
          }
          .frame(width: 137, height: 96)
          .offset(x: 0, y: 20.50)
        }
        .frame(width: 171, height: 171)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 93.50, y: 93.50)
      }
      .frame(width: 390, height: 390)
      .offset(x: 0, y: -49.81)
      ZStack() {
        ZStack() {
          Text("最近记录")
            .font(Font.custom("WenQuanYi Zen Hei", size: 20).weight(.bold))
            .lineSpacing(28)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: 0, y: 0)
        }
        .frame(width: 80, height: 28)
        .offset(x: -139, y: 8)
        ZStack() {
          Text("查看全部")
            .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.medium))
            .lineSpacing(20)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
            .offset(x: 0, y: 0)
        }
        .frame(width: 56, height: 20)
        .offset(x: 151, y: 8)
      }
      .frame(width: 390, height: 60)
      .offset(x: 0, y: 175.19)
      ZStack() {
        ZStack() {
          ZStack() {
            Text("85")
              .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
              .lineSpacing(24)
              .foregroundColor(.white)
              .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32))
          .cornerRadius(9999)
          .offset(x: -138, y: 0)
          ZStack() {
            ZStack() {
              Text("卦象辨识 ")
                .font(Font.custom("Song Myung", size: 14))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -68.17, y: 0)
            }
            .frame(width: 192.33, height: 20)
            .offset(x: 0, y: -8)
            ZStack() {
              Text("2023-11-20 • 用时 05:24")
                .font(Font.custom("Inter", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -26.17, y: 0)
            }
            .frame(width: 192.33, height: 16)
            .offset(x: 0, y: 10)
          }
          .frame(width: 192.33, height: 36)
          .offset(x: -1.83, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: -20, y: 0)
            ZStack() {
              Text("已完成")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.bold))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 36, height: 16)
            .offset(x: 7.84, y: 0)
          }
          .frame(width: 51.67, height: 16)
          .offset(x: 136.16, y: 0)
        }
        .frame(width: 358, height: 82)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: -94)
        ZStack() {
          ZStack() {
            Text("--")
              .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
              .lineSpacing(24)
              .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
              .offset(x: -0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(Color(red: 0.89, green: 0.91, blue: 0.94))
          .cornerRadius(9999)
          .offset(x: -138, y: 0)
          ZStack() {
            ZStack() {
              Text("爻辞匹对")
                .font(Font.custom("Song Myung", size: 14))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -68.17, y: 0)
            }
            .frame(width: 192.33, height: 20)
            .offset(x: 0, y: -8)
            ZStack() {
              Text("进行中 • 剩余 12 题")
                .font(Font.custom("Inter", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -43.17, y: 0)
            }
            .frame(width: 192.33, height: 16)
            .offset(x: 0, y: 10)
          }
          .frame(width: 192.33, height: 36)
          .offset(x: -1.83, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: -20, y: 0)
            ZStack() {
              Text("进行中")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.bold))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 36, height: 16)
            .offset(x: 7.84, y: 0)
          }
          .frame(width: 51.67, height: 16)
          .offset(x: 136.16, y: 0)
        }
        .frame(width: 358, height: 82)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: 0)
        ZStack() {
          ZStack() {
            Text("92")
              .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
              .lineSpacing(24)
              .foregroundColor(.white)
              .offset(x: -0.01, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.80))
          .cornerRadius(9999)
          .offset(x: -138, y: 0)
          ZStack() {
            ZStack() {
              Text("问答练习 ")
                .font(Font.custom("Song Myung", size: 14))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: -68.17, y: 0)
            }
            .frame(width: 192.33, height: 20)
            .offset(x: 0, y: -8)
            ZStack() {
              Text("2023-11-18 • 用时 08:12")
                .font(Font.custom("Inter", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -27.67, y: 0)
            }
            .frame(width: 192.33, height: 16)
            .offset(x: 0, y: 10)
          }
          .frame(width: 192.33, height: 36)
          .offset(x: -1.83, y: 0)
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: -20, y: 0)
            ZStack() {
              Text("已完成")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.bold))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 0, y: 0)
            }
            .frame(width: 36, height: 16)
            .offset(x: 7.84, y: 0)
          }
          .frame(width: 51.67, height: 16)
          .offset(x: 136.16, y: 0)
        }
        .frame(width: 358, height: 82)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 0.50
            )
        )
        .offset(x: 0, y: 94)
      }
      .frame(width: 390, height: 302)
      .offset(x: 0, y: 356.19)
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 390, height: 96)
        .offset(x: 0, y: 555.19)
      ZStack() {
        ZStack() {
          VStack(alignment: .leading, spacing: undefined) {

          }
          .offset(x: 0, y: -8.50)
          ZStack() {
            Text("首页")
              .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
              .lineSpacing(15)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: 0, y: 0)
          }
          .frame(width: 20, height: 15)
          .offset(x: 0, y: 12)
        }
        .frame(width: 83.50, height: 39)
        .offset(x: -137.25, y: -7.50)
        ZStack() {
          VStack(alignment: .leading, spacing: undefined) {

          }
          .offset(x: 0, y: -9.50)
          ZStack() {
            Text("练习")
              .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.bold))
              .lineSpacing(15)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: 0, y: 0)
          }
          .frame(width: 20, height: 15)
          .offset(x: 0, y: 12)
        }
        .frame(width: 83.50, height: 39)
        .offset(x: -45.75, y: -7.50)
        ZStack() {
          VStack(alignment: .leading, spacing: undefined) {

          }
          .offset(x: 0, y: -7.50)
          ZStack() {
            Text("学习")
              .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
              .lineSpacing(15)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: 0, y: 0)
          }
          .frame(width: 20, height: 15)
          .offset(x: 0, y: 12)
        }
        .frame(width: 83.50, height: 39)
        .offset(x: 45.75, y: -7.50)
        ZStack() {
          VStack(alignment: .leading, spacing: undefined) {

          }
          .offset(x: 0, y: -7.50)
          ZStack() {
            Text("个人")
              .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
              .lineSpacing(15)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: 0, y: 0)
          }
          .frame(width: 20, height: 15)
          .offset(x: 0, y: 12)
        }
        .frame(width: 83.50, height: 39)
        .offset(x: 137.25, y: -7.50)
      }
      .frame(width: 390, height: 72)
      .background(.white)
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(Color(red: 0.95, green: 0.96, blue: 0.98), lineWidth: 0.50)
      )
      .offset(x: 0, y: 566.81)
      ZStack() {
        ZStack() {
          Text("练习中心")
            .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
            .lineSpacing(22.50)
            .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
            .offset(x: 0, y: 0)
        }
        .frame(width: 278, height: 23)
        .offset(x: 0, y: -0.50)
      }
      .frame(width: 390, height: 73)
      .background(.white)
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
          )
      )
      .offset(x: 0, y: -566.69)
    }
    .frame(width: 390, height: 1206.38)
    .background(.white)
    .shadow(
      color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 10, y: 8
    );
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}