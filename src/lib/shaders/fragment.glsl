/*
 * Bakalarska prace
 * MODELOVANI A ANALYZA TRAJEKTORII SOFTBALLOVEHO NADHOZU
 *
 * Vysoke uceni technicke v Brne
 * Fakulta informacnich technologii
 * Ustav pocitacove grafiky a multimedii
 *
 * Autor:   Matej Nedela
 * Vedouci: Ing. Tomas Milet, Ph.D.
 */

/**
 * @file
 * @brief Fragment shader
 *
 * @author Matej Nedela
 */

varying vec3 vPosition; ///< varying variable to receive the position from the vertex shader

uniform float OUTFIELD_DISTANCE;
uniform float PITCHING_DISTANCE;
uniform vec3[50] pitch;

/**
 * @brief Rotates a point by 45 degrees
 *
 * @param p - point to rotate
 * @param c - center of the rotation
 *
 * @return point rotated by 45 degrees
 */
vec2 rotate(in vec2 p, in vec2 c) {
  float cos45deg = cos(radians(45.0));
  float sin45deg = sin(radians(45.0));

  return vec2(
    (p.x - c.x) * cos45deg - (p.y - c.y) * sin45deg,
    (p.x - c.x) * sin45deg + (p.y - c.y) * cos45deg
  );
}

/**
 * @brief Signed distance function for a circle
 *
 * @author Inigo Quilez
 * @copyright MIT License
 * @see https://iquilezles.org/articles/distfunctions2d
 *
 * @param p - point to check
 * @param c - center of the circle
 * @param r - radius of the circle
 *
 * @return distance from the point to the edge of the circle
 */
float sdfCircle(in vec2 p, in vec2 c, in float r) {
  vec2 pc = p - c;

  return length(pc) - r;
}

/**
 * @brief Signed distance function for a segment
 *
 * @author Inigo Quilez
 * @copyright MIT License
 * @see https://iquilezles.org/articles/distfunctions2d
 *
 * @param p - point to check
 * @param a - start point of the segment
 * @param b - end point of the segment
 *
 * @return distance from the point to the edge of the segment
 */
float sdfSegment(in vec2 p, in vec2 a, in vec2 b) {
  vec2 pa = p - a;
  vec2 ba = b - a;

  return length(pa - ba * clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0));
}

/**
 * @brief Signed distance function for a box
 *
 * @author Inigo Quilez
 * @copyright MIT License
 * @see https://iquilezles.org/articles/distfunctions2d
 *
 * @param p - point to check
 * @param a - start point of the box
 * @param b - end point of the box
 *
 * @return distance from the point to the edge of the box
 */
float sdfBox(in vec2 p, in vec2 a, in vec2 b) {
  vec2 d = abs(p - (a + b) / 2.0) - abs(b - a) / 2.0;

  return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

/**
 * @brief Signed distance function for a box rotated by 45 degrees
 *
 * @author Inigo Quilez
 * @copyright MIT License
 * @see https://iquilezles.org/articles/distfunctions2d
 *
 * @param p - point to check
 * @param a - start point of the box
 * @param b - end point of the box
 *
 * @return distance from the point to the edge of the box rotated by 45 degrees
 */
float sdfBoxRotated(in vec2 p, in vec2 a, in vec2 b) {
  vec2 c = (a + b) / 2.0;
  vec2 d = abs(rotate(p, c)) - abs(rotate(b, c) - rotate(a, c)) / 2.0;

  return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

/**
 * @brief Signed distance function for a polygon
 *
 * @author Inigo Quilez
 * @copyright MIT License
 * @see https://iquilezles.org/articles/distfunctions2d
 *
 * @param p - point to check
 * @param v - array of vertices of the polygon
 *
 * @return distance from the point to the edge of the polygon
 */
float sdfPolygon(in vec2 p, in vec2[5] v) {
  float d = dot(p - v[0], p - v[0]);
  float s = 1.0;

  for (int i = 0, j = 4; i < 5; j = i, ++i) {
    vec2 e = v[j] - v[i];
    vec2 w = p - v[i];
    vec2 b = w - e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);

    d = min(d, dot(b, b));

    bvec3 c = bvec3(p.y >= v[i].y, p.y < v[j].y, e.x * w.y > e.y * w.x);

    if (all(c) || all(not(c))) {
      s *= -1.0;
    }
  }

  return s * sqrt(d);
}

/**
 * @brief Fragment shader main function
 */
void main() {
  // outfield fence
  if (sdfCircle(vPosition.xz, vec2(0.0, 0.0), OUTFIELD_DISTANCE) > 0.0) {
    discard;
    return;
  }

  // backstop
  if (vPosition.x < -8.23) {
    discard;
    return;
  }

  // pitcher's plate
  float pitchersPlate = sdfBox(vPosition.xz, vec2(PITCHING_DISTANCE, -0.305), vec2(PITCHING_DISTANCE + 0.152, 0.305));
  if (pitchersPlate < 0.0) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    return;
  } else if (pitchersPlate < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // home plate
  float homePlate = sdfPolygon(vPosition.xz, vec2[](vec2(0.0, 0.0), vec2(0.216, -0.216), vec2(0.432, -0.216), vec2(0.432, 0.216), vec2(0.216, 0.216)));
  if (homePlate < 0.0) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    return;
  } else if (homePlate < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // first base
  float firstBase = sdfBoxRotated(vPosition.xz, vec2(18.29 / sqrt(2.0), 18.29 / sqrt(2.0) - 0.38 * sqrt(2.0)), vec2(18.29 / sqrt(2.0), 18.29 / sqrt(2.0)));
  if (firstBase < 0.0) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    return;
  } else if (firstBase < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // second base
  float secondBase = sdfBoxRotated(vPosition.xz, vec2(36.58 / sqrt(2.0) - 0.19 * sqrt(2.0), 0.0), vec2(36.58 / sqrt(2.0) + 0.19 * sqrt(2.0), 0.0));
  if (secondBase < 0.0) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    return;
  } else if (secondBase < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // third base
  float thirdBase = sdfBoxRotated(vPosition.xz, vec2(18.29 / sqrt(2.0), -18.29 / sqrt(2.0) + 0.38 * sqrt(2.0)), vec2(18.29 / sqrt(2.0), -18.29 / sqrt(2.0)));
  if (thirdBase < 0.0) {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    return;
  } else if (thirdBase < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // grass line
  if (abs(sdfCircle(vPosition.xz, vec2(18.29 / sqrt(2.0), 0.0), 18.29)) < 0.05 && vPosition.x > abs(vPosition.z)) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // pitcher's circle
  if (abs(sdfCircle(vPosition.xz, vec2(PITCHING_DISTANCE, 0.0), 2.44)) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // right foul line
  if (sdfSegment(vPosition.xz, vec2(1.28, 1.28), vec2(OUTFIELD_DISTANCE / sqrt(2.0), OUTFIELD_DISTANCE / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // left foul line
  if (sdfSegment(vPosition.xz, vec2(1.28, -1.28), vec2(OUTFIELD_DISTANCE / sqrt(2.0), -OUTFIELD_DISTANCE / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // right base line
  if (sdfSegment(vPosition.xz, vec2(18.29 / sqrt(2.0), 18.29 / sqrt(2.0)), vec2(36.58 / sqrt(2.0), 0.0)) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // left base line
  if (sdfSegment(vPosition.xz, vec2(18.29 / sqrt(2.0), -18.29 / sqrt(2.0)), vec2(36.58 / sqrt(2.0), 0.0)) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // right batter's box
  if (abs(sdfBox(vPosition.xz, vec2(-0.694, 0.37), vec2(1.436, 1.28))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // left batter's box
  if (abs(sdfBox(vPosition.xz, vec2(-0.694, -0.37), vec2(1.436, -1.28))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // catcher's box
  if (abs(sdfBox(vPosition.xz, vec2(-3.744, -1.28), vec2(-0.694, 1.28))) < 0.05 && vPosition.x < abs(vPosition.z) - 1.974) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // one meter line
  if (sdfSegment(vPosition.xz, vec2(9.145 / sqrt(2.0), 9.145 / sqrt(2.0)), vec2(8.235 / sqrt(2.0), 10.055 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  } else if (sdfSegment(vPosition.xz, vec2(8.235 / sqrt(2.0), 10.055 / sqrt(2.0)), vec2(17.38 / sqrt(2.0), 19.2 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // right coach's box
  if (sdfSegment(vPosition.xz, vec2(9.15 / sqrt(2.0), 18.29 / sqrt(2.0)), vec2(10.06 / sqrt(2.0), 17.38 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  } else if (sdfSegment(vPosition.xz, vec2(10.06 / sqrt(2.0), 17.38 / sqrt(2.0)), vec2(14.63 / sqrt(2.0), 21.95 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  } else if (sdfSegment(vPosition.xz, vec2(14.63 / sqrt(2.0), 21.95 / sqrt(2.0)), vec2(13.72 / sqrt(2.0), 22.86 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  // left coach's box
  if (sdfSegment(vPosition.xz, vec2(9.15 / sqrt(2.0), -18.29 / sqrt(2.0)), vec2(10.06 / sqrt(2.0), -17.38 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  } else if (sdfSegment(vPosition.xz, vec2(10.06 / sqrt(2.0), -17.38 / sqrt(2.0)), vec2(14.63 / sqrt(2.0), -21.95 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  } else if (sdfSegment(vPosition.xz, vec2(14.63 / sqrt(2.0), -21.95 / sqrt(2.0)), vec2(13.72 / sqrt(2.0), -22.86 / sqrt(2.0))) < 0.05) {
    gl_FragColor = vec4(0.26, 0.26, 0.26, 1.0);
    return;
  }

  float r = 0.93;
  float g = 0.93;
  float b = 0.93;

  // pitch shadow
  for (int i = 0; i < 49; ++i) {
    float pitchShadow = sdfSegment(vPosition.xz, pitch[i].xz, pitch[i + 1].xz);
    if (pitchShadow < 0.1) {
      r = min(r, mix(0.93, 0.78, smoothstep(0.1, 0.0, pitchShadow) / 2.0));
      g = min(g, mix(0.93, 0.16, smoothstep(0.1, 0.0, pitchShadow) / 2.0));
      b = min(b, mix(0.93, 0.16, smoothstep(0.1, 0.0, pitchShadow) / 2.0));
    }
  }

  gl_FragColor = vec4(r, g, b, 1.0);
}
