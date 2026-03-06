import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      ZStack() {
        ZStack() {
          ZStack() {
            Text("当前进度")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.semibold))
              .tracking(0.60)
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.70))
              .offset(x: -5.28, y: -16.25)
            ZStack() {
              Text("06 ")
                .font(Font.custom("Inter", size: 24).weight(.bold))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: -13.98, y: -0.50)
              Text("/ 10")
                .font(Font.custom("Inter", size: 14))
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
                .offset(x: 18.73, y: 2.50)
            }
            .frame(width: 60.97, height: 32)
            .offset(x: 0, y: 8.25)
          }
          .frame(width: 60.97, height: 48.50)
          .offset(x: -148.51, y: 0)
          ZStack() {
            Text("当前得分")
              .font(Font.custom("WenQuanYi Zen Hei", size: 12).weight(.semibold))
              .tracking(0.60)
              .lineSpacing(16)
              .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.70))
              .offset(x: 0, y: -16.25)
            ZStack() {
              Text("85")
                .font(Font.custom("Inter", size: 24).weight(.bold))
                .lineSpacing(32)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
                .offset(x: 9.93, y: 0)
            }
            .frame(width: 50.41, height: 32)
            .offset(x: 0, y: 8.25)
          }
          .frame(width: 50.41, height: 48.50)
          .offset(x: 153.79, y: 0)
        }
        .frame(width: 358, height: 48.50)
        .offset(x: 0, y: -8)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 214.80, height: 8)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32))
            .cornerRadius(9999)
            .offset(x: -71.60, y: 0)
        }
        .frame(width: 358, height: 8)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10))
        .cornerRadius(9999)
        .offset(x: 0, y: 28.25)
      }
      .frame(width: 358, height: 64.50)
      .offset(x: 0, y: 0)
    }
    .frame(width: 390, height: 96.50)
    .background(.white)
    ZStack() {
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Text("单选题")
                .font(Font.custom("WenQuanYi Zen Hei", size: 14).weight(.medium))
                .tracking(1.40)
                .lineSpacing(20)
                .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60))
                .offset(x: 0, y: 0)
            }
            .frame(width: 46.20, height: 20)
            .offset(x: 0, y: -8)
          }
          .frame(width: 46.20, height: 36)
          .offset(x: 0, y: -37.50)
          ZStack() {
            Text("“大壮：利贞。”")
              .font(Font.custom("WenQuanYi Zen Hei", size: 24).weight(.bold))
              .lineSpacing(39)
              .foregroundColor(Color(red: 0.12, green: 0.16, blue: 0.23))
              .offset(x: 0, y: -18)
            ZStack() {
              Text("这是哪一卦的卦辞？")
                .font(Font.custom("WenQuanYi Zen Hei", size: 18))
                .lineSpacing(28)
                .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                .offset(x: -0.02, y: 0)
            }
            .frame(width: 169.73, height: 28)
            .offset(x: 0, y: 23.50)
          }
          .frame(width: 169.73, height: 75)
          .offset(x: 0, y: 18)
          VStack(spacing: undefined) {

          }
          .frame(width: 240, height: 360)
          .offset(x: 0, y: 0)
        }
        .frame(width: 358, height: 185)
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
        .shadow(
          color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
        )
      }
      .frame(width: 358, height: 233)
      .offset(x: 0, y: -200)
      ZStack() {
        ZStack() {
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 8, height: 8)
                .background(.white)
                .cornerRadius(9999)
                .offset(x: 0, y: 0)
            }
            .frame(width: 24, height: 24)
            .cornerRadius(9999)
            .overlay(
              RoundedRectangle(cornerRadius: 9999)
                .inset(by: 1)
                .stroke(
                  Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20), lineWidth: 1
                )
            )
            .offset(x: -149, y: 0)
            ZStack() {
              Text("乾卦")
                .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 8, y: 0)
            }
            .frame(width: 48, height: 24)
            .offset(x: -113, y: 0)
          }
          .frame(width: 358, height: 60)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 1
              )
          )
          .offset(x: 0, y: -108)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 8, height: 8)
                .background(.white)
                .cornerRadius(9999)
                .offset(x: 0, y: 0)
            }
            .frame(width: 24, height: 24)
            .cornerRadius(9999)
            .overlay(
              RoundedRectangle(cornerRadius: 9999)
                .inset(by: 1)
                .stroke(
                  Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20), lineWidth: 1
                )
            )
            .offset(x: -149, y: 0)
            ZStack() {
              Text("坤卦")
                .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 8, y: 0)
            }
            .frame(width: 48, height: 24)
            .offset(x: -113, y: 0)
          }
          .frame(width: 358, height: 60)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 1
              )
          )
          .offset(x: 0, y: -36)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 8, height: 8)
                .background(.white)
                .cornerRadius(9999)
                .offset(x: 0, y: 0)
            }
            .frame(width: 24, height: 24)
            .background(Color(red: 0.03, green: 0.42, blue: 0.32))
            .cornerRadius(9999)
            .overlay(
              RoundedRectangle(cornerRadius: 9999)
                .inset(by: 1)
                .stroke(
                  Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20), lineWidth: 1
                )
            )
            .offset(x: -149, y: 0)
            ZStack() {
              Text("雷天大壮")
                .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 8, y: 0)
            }
            .frame(width: 80, height: 24)
            .offset(x: -97, y: 0)
          }
          .frame(width: 358, height: 60)
          .background(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05))
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(Color(red: 0.03, green: 0.42, blue: 0.32), lineWidth: 1)
          )
          .offset(x: 0, y: 36)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
          ZStack() {
            ZStack() {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 8, height: 8)
                .background(.white)
                .cornerRadius(9999)
                .offset(x: 0, y: 0)
            }
            .frame(width: 24, height: 24)
            .cornerRadius(9999)
            .overlay(
              RoundedRectangle(cornerRadius: 9999)
                .inset(by: 1)
                .stroke(
                  Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.20), lineWidth: 1
                )
            )
            .offset(x: -149, y: 0)
            ZStack() {
              Text("地火明夷")
                .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.medium))
                .lineSpacing(24)
                .foregroundColor(Color(red: 0.20, green: 0.25, blue: 0.33))
                .offset(x: 8, y: 0)
            }
            .frame(width: 80, height: 24)
            .offset(x: -97, y: 0)
          }
          .frame(width: 358, height: 60)
          .background(.white)
          .cornerRadius(12)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .inset(by: 1)
              .stroke(
                Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.05), lineWidth: 1
              )
          )
          .offset(x: 0, y: 108)
          .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 2, y: 1
          )
        }
        .frame(width: 358, height: 276)
        .offset(x: 0, y: -16)
      }
      .frame(width: 358, height: 308)
      .offset(x: 0, y: 70.50)
      ZStack() {
        ZStack() {
          Text("上一题")
            .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
            .lineSpacing(24)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
            .offset(x: 0, y: 0)
        }
        .frame(width: 171, height: 60)
        .cornerRadius(12)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .inset(by: 1)
            .stroke(Color(red: 0.03, green: 0.42, blue: 0.32), lineWidth: 1)
        )
        .offset(x: -93.50, y: -16)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 171, height: 60)
            .background(Color(red: 1, green: 1, blue: 1).opacity(0))
            .cornerRadius(12)
            .offset(x: 0, y: 0)
            .shadow(
              color: Color(red: 0.03, green: 0.42, blue: 0.32, opacity: 0.20), radius: 6, y: 4
            )
          Text("下一题")
            .font(Font.custom("WenQuanYi Zen Hei", size: 16).weight(.bold))
            .lineSpacing(24)
            .foregroundColor(.white)
            .offset(x: 0, y: 0)
        }
        .frame(width: 171, height: 60)
        .background(Color(red: 0.03, green: 0.42, blue: 0.32))
        .cornerRadius(12)
        .offset(x: 93.50, y: -16)
      }
      .frame(width: 358, height: 92)
      .offset(x: 0, y: 270.50)
    }
    .frame(width: 390, height: 665)
    ZStack() {
      ZStack() {
        VStack(alignment: .leading, spacing: undefined) {

        }
        .offset(x: 0, y: -9.50)
        ZStack() {
          Text("学堂")
            .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
            .lineSpacing(15)
            .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
            .offset(x: 0, y: 0)
        }
        .frame(width: 20, height: 15)
        .offset(x: 0, y: 10)
      }
      .frame(width: 22, height: 35)
      .offset(x: -135.27, y: 0.50)
      ZStack() {
        VStack(alignment: .leading, spacing: undefined) {

        }
        .offset(x: 0, y: -9.50)
        ZStack() {
          Text("练习")
            .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
            .lineSpacing(15)
            .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32))
            .offset(x: 0, y: 0)
        }
        .frame(width: 20, height: 15)
        .offset(x: 0, y: 12)
      }
      .frame(width: 20, height: 39)
      .offset(x: -48.77, y: 0.50)
      ZStack() {
        VStack(alignment: .leading, spacing: undefined) {

        }
        .offset(x: 0, y: -9.50)
        ZStack() {
          Text("发现")
            .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
            .lineSpacing(15)
            .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
            .offset(x: 0, y: 0)
        }
        .frame(width: 20, height: 15)
        .offset(x: 0, y: 12)
      }
      .frame(width: 20, height: 39)
      .offset(x: 36.73, y: 0.50)
      ZStack() {
        VStack(alignment: .leading, spacing: undefined) {

        }
        .offset(x: 0, y: -9.50)
        ZStack() {
          Text("我的")
            .font(Font.custom("WenQuanYi Zen Hei", size: 10).weight(.medium))
            .lineSpacing(15)
            .foregroundColor(Color(red: 0.58, green: 0.64, blue: 0.72))
            .offset(x: 0, y: 0)
        }
        .frame(width: 20, height: 15)
        .offset(x: 0, y: 10)
      }
      .frame(width: 20, height: 35)
      .offset(x: 122.23, y: 0.50)
    }
    .frame(width: 390, height: 56)
    .background(.white)
    .overlay(
      Rectangle()
        .inset(by: 0.50)
        .stroke(
          Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.10), lineWidth: 0.50
        )
    )
    ZStack() {
      ZStack() {
        VStack(spacing: undefined) {

        }
        .offset(x: 0, y: 0)
      }
      .frame(width: 40, height: 40)
      .offset(x: -159, y: -0.50)
      ZStack() {
        Text("知识问答")
          .font(Font.custom("WenQuanYi Zen Hei", size: 18).weight(.bold))
          .lineSpacing(28)
          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
          .offset(x: 0, y: 0)
      }
      .frame(width: 72, height: 28)
      .offset(x: 0, y: -0.50)
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
    Text("跳过此题")
      .font(Font.custom("Noto Sans SC", size: 16).weight(.medium))
      .lineSpacing(24)
      .foregroundColor(Color(red: 0.03, green: 0.42, blue: 0.32).opacity(0.60));
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}