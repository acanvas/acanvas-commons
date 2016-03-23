part of rockdot_commons;

class RdGraphics {
  static Sprite rectangle(num x, num y, num w, num h,
      {int color: 0xFF000000, Sprite sprite: null, bool round: false, bool clear: true}) {
    if (sprite == null) {
      sprite = new Sprite();
    } else if (clear == true) {
      sprite.graphics.clear();
    }

    if (round) {
      x = x.round();
      y = y.round();
      w = w.round();
      h = h.round();
    }

    sprite.graphics.beginPath();
    sprite.graphics.rect(x, y, w, h);
    sprite.graphics.fillColor(color);
    sprite.graphics.closePath();

    if (Rd.WEBGL && w.round() > 0 && h.round() > 0) {
      //sprite.applyCache(x.round(), y.round(), w.round(), h.round());
    }

    return sprite;
  }

  static Sprite rectRound(num x, num y, num w, num h, num ew, num eh,
      {int color: 0xFF000000, Sprite sprite: null, bool round: false, bool clear: true}) {
    if (sprite == null) {
      sprite = new Sprite();
    } else if (clear == true) {
      sprite.graphics.clear();
    }

    if (round) {
      x = x.round();
      y = y.round();
      w = w.round();
      h = h.round();
      ew = ew.round();
      eh = eh.round();
    }

    sprite.graphics.rectRound(x, y, w, h, ew, eh);
    sprite.graphics.fillColor(color);

    if (Rd.WEBGL && w.round() > 0 && h.round() > 0) {
      //sprite.applyCache(x.round(), y.round(), w.round(), h.round());
    }

    return sprite;
  }

  static Sprite circle(num x, num y, num r,
      {int color: 0xFF000000, Sprite sprite: null, bool round: false, bool clear: true}) {
    if (sprite == null) {
      sprite = new Sprite();
    } else if (clear == true) {
      sprite.graphics.clear();
    }

    if (round) {
      x = x.round();
      y = y.round();
      r = r.round();
    }

    sprite.graphics.beginPath();
    sprite.graphics.circle(x, y, r);
    sprite.graphics.fillColor(color);
    sprite.graphics.closePath();

    if (Rd.WEBGL && (x + r).round() > 0) {
      //sprite.applyCache((x - r).round(), (y - r).round(), (2*r).round(), (2*r).round());
    }

    return sprite;
  }

  static Sprite line(num x, num y, {int color: 0xFF000000, num strength: 1, Sprite sprite: null, bool round: false}) {
    if (sprite == null) {
      sprite = new Sprite();
    } else {
      sprite.graphics.clear();
    }

    if (round) {
      x = x.round();
      y = y.round();
    }

    sprite.graphics.beginPath();
    sprite.graphics.moveTo(0, 0);
    sprite.graphics.lineTo(x, y);
    sprite.graphics.strokeColor(color, strength);
    sprite.graphics.closePath();

    if (Rd.WEBGL) {
      //sprite.applyCache(0, 0, x == 0 ? strength.ceil() : x.ceil(), y == 0 ? strength.ceil() : y.ceil());
    }

    return sprite;
  }

  static GraphicsGradient linearGraphicsGradient(List colors, List alphas, List ratios, Matrix matrix) {
    GraphicsGradient g = new GraphicsGradient.linear(matrix.tx, matrix.ty, matrix.a * matrix.c, matrix.b * matrix.d);
    for (int i = 0; i < colors.length; i++) {
      g.addColorStop(ratios[i] / 255, ((alphas[i] * 256).round() << 24) + colors[i]);
    }
    return g;
  }
}
