import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 358, height: 139)
        .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
        .offset(x: 1, y: -329)
      ZStack() {
        ZStack() {
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(.white)
          .cornerRadius(16)
          .offset(x: 0, y: -12)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            Text("基础知识")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
              .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 16)
          .offset(x: 0, y: 28)
        }
        .frame(width: 83.50, height: 72)
        .offset(x: -137.25, y: 0.50)
        ZStack() {
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(.white)
          .cornerRadius(16)
          .offset(x: 0, y: -12)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            Text("占卜工具")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
              .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 16)
          .offset(x: 0, y: 28)
        }
        .frame(width: 83.50, height: 72)
        .offset(x: -45.75, y: 0.50)
        ZStack() {
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(.white)
          .cornerRadius(16)
          .offset(x: 0, y: -12)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            Text("经典经文")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
              .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 16)
          .offset(x: 0, y: 28)
        }
        .frame(width: 83.50, height: 72)
        .offset(x: 45.75, y: 0.50)
        ZStack() {
          ZStack() {
            VStack(alignment: .leading, spacing: undefined) {

            }
            .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 48)
          .background(.white)
          .cornerRadius(16)
          .offset(x: 0, y: -12)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            Text("交流论坛")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
              .offset(x: 0, y: 0)
          }
          .frame(width: 48, height: 16)
          .offset(x: 0, y: 28)
        }
        .frame(width: 83.50, height: 72)
        .offset(x: 137.25, y: 0.50)
      }
      .frame(width: 390, height: 111)
      .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
      .offset(x: 0, y: 56)
      ZStack() {
        Text("学习概览")
          .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
          .lineSpacing(28)
          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
          .offset(x: -126.50, y: 8)
      }
      .frame(width: 357, height: 60)
      .offset(x: 0.50, y: 141.50)
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: -32.25, y: 0)
              ZStack() {
                Text("已学卦象")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                  .lineSpacing(16)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 48, height: 16)
              .offset(x: 6.16, y: 0)
            }
            .frame(width: 77.33, height: 16)
            .offset(x: 0, y: -2)
          }
          .frame(width: 77.33, height: 20)
          .offset(x: 0, y: -31.50)
          ZStack() {
            Text("6")
              .font(Font.custom("Inter", size: 24).weight(.bold))
              .lineSpacing(32)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: -30.87, y: -0.50)
            Text(" / 64")
              .font(Font.custom("Inter", size: 14))
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: -7.74, y: 2.50)
          }
          .frame(width: 77.33, height: 32)
          .offset(x: 0, y: -1.50)
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 7.72, height: 4)
                .background(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -34.80, y: 0)
            }
            .frame(width: 77.33, height: 4)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
            .cornerRadius(9999)
            .offset(x: 0, y: 4)
          }
          .frame(width: 77.33, height: 12)
          .offset(x: 0, y: 24.50)
        }
        .frame(width: 111.33, height: 117)
        .background(.white)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: -123.34, y: 0)
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
        )
        ZStack() {
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: -34.58, y: 0)
              ZStack() {
                Text("我的收藏")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                  .lineSpacing(16)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 48, height: 16)
              .offset(x: 1.49, y: 0)
            }
            .frame(width: 77.33, height: 16)
            .offset(x: 0, y: -2)
          }
          .frame(width: 77.33, height: 20)
          .offset(x: 0, y: -31.50)
          ZStack() {
            Text("0")
              .font(Font.custom("Inter", size: 24).weight(.bold))
              .lineSpacing(32)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: -30.16, y: 0)
          }
          .frame(width: 77.33, height: 32)
          .offset(x: 0, y: -1.50)
          ZStack() {
            ZStack() {
              Text("暂无收藏")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 77.33, height: 15)
            .offset(x: 0, y: 4)
          }
          .frame(width: 77.33, height: 23)
          .offset(x: 0, y: 30)
        }
        .frame(width: 111.33, height: 117)
        .background(.white)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: -0, y: 0)
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
        )
        ZStack() {
          ZStack() {
            ZStack() {
              VStack(alignment: .leading, spacing: undefined) {

              }
              .offset(x: -34, y: 0)
              ZStack() {
                Text("连续学习")
                  .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
                  .lineSpacing(16)
                  .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                  .offset(x: 0, y: 0)
              }
              .frame(width: 48, height: 16)
              .offset(x: 2.66, y: 0)
            }
            .frame(width: 77.33, height: 16)
            .offset(x: 0, y: -2)
          }
          .frame(width: 77.33, height: 20)
          .offset(x: 0, y: -31.50)
          ZStack() {
            Text("1")
              .font(Font.custom("Inter", size: 24).weight(.bold))
              .lineSpacing(32)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
              .offset(x: -33.48, y: -0.50)
            Text(" 天")
              .font(Font.custom("WenQuanYi Zen Hei", size: 14))
              .lineSpacing(20)
              .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
              .offset(x: -19.34, y: 2.50)
          }
          .frame(width: 77.33, height: 32)
          .offset(x: 0, y: -1.50)
          ZStack() {
            ZStack() {
              Text("打败了 12% 用户")
                .font(Font.custom("WenQuanYi Zen Hei", size: 10))
                .lineSpacing(15)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 77.33, height: 15)
            .offset(x: 0, y: 4)
          }
          .frame(width: 77.33, height: 23)
          .offset(x: 0, y: 30)
        }
        .frame(width: 111.33, height: 117)
        .background(.white)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 0.50)
            .stroke(
              Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
            )
        )
        .offset(x: 123.34, y: 0)
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
        )
      }
      .frame(width: 390, height: 149)
      .offset(x: 0, y: 245.75)
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 390, height: 80.25)
        .offset(x: 0, y: 434.38)
      ZStack() {
        VStack(spacing: 4) {
          VStack(alignment: .leading, spacing: undefined) {

          }
          VStack(alignment: .leading, spacing: undefined) {
            Text("首页")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
          }
        }
        .frame(width: 89.50)
        .offset(x: -134.25, y: 0)
        VStack(spacing: 4) {
          VStack(alignment: .leading, spacing: undefined) {

          }
          VStack(alignment: .leading, spacing: undefined) {
            Text("百科")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
          }
        }
        .frame(width: 89.50)
        .offset(x: -44.75, y: 0)
        VStack(spacing: 4) {
          VStack(alignment: .leading, spacing: undefined) {

          }
          VStack(alignment: .leading, spacing: undefined) {
            Text("练习")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
          }
        }
        .frame(width: 89.50)
        .offset(x: 44.75, y: 0)
        VStack(spacing: 4) {
          VStack(alignment: .leading, spacing: undefined) {

          }
          VStack(alignment: .leading, spacing: undefined) {
            Text("我的")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.medium))
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
          }
        }
        .frame(width: 89.50)
        .offset(x: 134.25, y: 0)
      }
      .frame(width: 390, height: 76)
      .background(Color(red: 1, green: 1, blue: 1).opacity(0.95))
      .overlay(
        Rectangle()
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
          )
      )
      .offset(x: 0, y: 436.50)
      ZStack() {
        ZStack() {
          Text("易经国学堂")
            .font(Font.custom("WenQuanYi Zen Hei", size: 20).weight(.bold))
            .lineSpacing(25)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
            .offset(x: 0, y: 0)
        }
        .frame(width: 278, height: 25)
        .offset(x: 0, y: 3.50)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 40, height: 40)
          .offset(x: 159, y: 3.50)
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
      .offset(x: 0, y: -442)
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Text("每日一卦")
                .font(
                  Font.custom("Abhaya Libre SemiBold", size: 14).weight(.semibold)
                )
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -62.08, y: 0)
            }
            .frame(width: 180.16, height: 20)
            .offset(x: 0, y: -27)
            ZStack() {
              Text("第56卦 火山旅 ")
                .font(Font.custom("Inter", size: 20).weight(.bold))
                .lineSpacing(25)
                .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                .offset(x: 0, y: 0)
            }
            .frame(width: 180.16, height: 50)
            .offset(x: 0, y: 12)
          }
          .frame(width: 180.16, height: 74)
          .offset(x: -67.92, y: 0)
          ZStack() {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32))
              .cornerRadius(9999)
              .offset(x: 0, y: -15)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32))
              .cornerRadius(9999)
              .offset(x: 0, y: -9)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
              .cornerRadius(9999)
              .offset(x: 0, y: -3)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32))
              .cornerRadius(9999)
              .offset(x: 0, y: 3)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
              .cornerRadius(9999)
              .offset(x: 0, y: 9)
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 32, height: 4)
              .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20))
              .cornerRadius(9999)
              .offset(x: 0, y: 15)
          }
          .frame(width: 48, height: 50)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(8)
          .offset(x: 134, y: -12)
        }
        .frame(width: 316, height: 74)
        .offset(x: 0, y: -61)
        ZStack() {
          Text(""羁旅艰辛，守正当吉。宜保持谦逊，在变动中寻求\n稳健发展。"")
            .font(Font.custom("WenQuanYi Zen Hei", size: 14))
            .lineSpacing(22.75)
            .foregroundColor(Color(red: 0.28, green: 0.33, blue: 0.41))
            .offset(x: -0.74, y: -0.32)
        }
        .frame(width: 316, height: 46.63)
        .offset(x: 0, y: 6.19)
        ZStack() {
          ZStack() {
            ZStack() {
              Text("离下艮上 · 旅卦")
                .font(Font.custom("WenQuanYi Zen Hei", size: 12))
                .lineSpacing(16)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 0, y: 0)
            }
            .frame(width: 82.22, height: 16)
            .offset(x: -116.89, y: 8.50)
            ZStack() {
              Text("查看详情")
                .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.medium))
                .lineSpacing(20)
                .foregroundColor(.white)
                .offset(x: 0, y: -0.50)
            }
            .frame(width: 104, height: 36)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32))
            .cornerRadius(8)
            .offset(x: 106, y: 8.50)
          }
          .frame(width: 316, height: 53)
          .overlay(
            Rectangle()
              .inset(by: 0.50)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 0.50
              )
          )
          .offset(x: 0, y: 4)
        }
        .frame(width: 316, height: 61)
        .offset(x: 0, y: 68)
      }
      .frame(width: 358, height: 232)
      .background(.white)
      .cornerRadius(12)
      .overlay(
        RoundedRectangle(cornerRadius: 12)
          .inset(by: 0.50)
          .stroke(
            Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 0.50
          )
      )
      .offset(x: 1, y: -133.50)
      .shadow(
        color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 6, y: 4
      )
    }
    .frame(width: 390, height: 949)
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