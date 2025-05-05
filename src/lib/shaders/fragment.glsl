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
uniform bvec3 enabled;
uniform vec3[10] pitch0;
uniform vec3[10] pitch1;
uniform vec3[10] pitch2;

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
  vec3[3] vPositions = vec3[3](
    vPosition - dFdx(vPosition),
    vPosition - dFdy(vPosition),
    vPosition
  );

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

  float d = OUTFIELD_DISTANCE, f = 0.0;

  for (int i = 0; i < 3; ++i) {
    d = OUTFIELD_DISTANCE;

    // grass line
    if (vPositions[i].x > abs(vPositions[i].z)) {
      d = min(d, abs(sdfCircle(vPositions[i].xz, vec2(18.29 / sqrt(2.0), 0.0), 18.29)));
    }

    // pitcher's circle
    d = min(d, abs(sdfCircle(vPositions[i].xz, vec2(PITCHING_DISTANCE, 0.0), 2.44)));

    // right foul line
    d = min(d, sdfSegment(vPositions[i].xz, vec2(1.28, 1.28), vec2(OUTFIELD_DISTANCE / sqrt(2.0), OUTFIELD_DISTANCE / sqrt(2.0))));

    // left foul line
    d = min(d, sdfSegment(vPositions[i].xz, vec2(1.28, -1.28), vec2(OUTFIELD_DISTANCE / sqrt(2.0), -OUTFIELD_DISTANCE / sqrt(2.0))));

    // right base line
    d = min(d, sdfSegment(vPositions[i].xz, vec2(18.29 / sqrt(2.0), 18.29 / sqrt(2.0)), vec2(36.58 / sqrt(2.0), 0.0)));

    // left base line
    d = min(d, sdfSegment(vPositions[i].xz, vec2(18.29 / sqrt(2.0), -18.29 / sqrt(2.0)), vec2(36.58 / sqrt(2.0), 0.0)));

    // right batter's box
    d = min(d, abs(sdfBox(vPositions[i].xz, vec2(-0.694, 0.37), vec2(1.436, 1.28))));

    // left batter's box
    d = min(d, abs(sdfBox(vPositions[i].xz, vec2(-0.694, -0.37), vec2(1.436, -1.28))));

    // catcher's box
    if (vPositions[i].x < abs(vPositions[i].z) - 1.974) {
      d = min(d, abs(sdfBox(vPositions[i].xz, vec2(-3.744, -1.28), vec2(-0.694, 1.28))));
    }

    // one meter line
    d = min(d, sdfSegment(vPositions[i].xz, vec2(9.145 / sqrt(2.0), 9.145 / sqrt(2.0)), vec2(8.235 / sqrt(2.0), 10.055 / sqrt(2.0))));
    d = min(d, sdfSegment(vPositions[i].xz, vec2(8.235 / sqrt(2.0), 10.055 / sqrt(2.0)), vec2(17.38 / sqrt(2.0), 19.2 / sqrt(2.0))));

    // right coach's box
    d = min(d, sdfSegment(vPositions[i].xz, vec2(9.15 / sqrt(2.0), 18.29 / sqrt(2.0)), vec2(10.06 / sqrt(2.0), 17.38 / sqrt(2.0))));
    d = min(d, sdfSegment(vPositions[i].xz, vec2(10.06 / sqrt(2.0), 17.38 / sqrt(2.0)), vec2(14.63 / sqrt(2.0), 21.95 / sqrt(2.0))));
    d = min(d, sdfSegment(vPositions[i].xz, vec2(14.63 / sqrt(2.0), 21.95 / sqrt(2.0)), vec2(13.72 / sqrt(2.0), 22.86 / sqrt(2.0))));

    // left coach's box
    d = min(d, sdfSegment(vPositions[i].xz, vec2(9.15 / sqrt(2.0), -18.29 / sqrt(2.0)), vec2(10.06 / sqrt(2.0), -17.38 / sqrt(2.0))));
    d = min(d, sdfSegment(vPositions[i].xz, vec2(10.06 / sqrt(2.0), -17.38 / sqrt(2.0)), vec2(14.63 / sqrt(2.0), -21.95 / sqrt(2.0))));
    d = min(d, sdfSegment(vPositions[i].xz, vec2(14.63 / sqrt(2.0), -21.95 / sqrt(2.0)), vec2(13.72 / sqrt(2.0), -22.86 / sqrt(2.0))));

    f = max(f, fwidth(d));
  }

  float w = max(0.05, f);
  float c = mix(0.26, 0.93, smoothstep(w, w + f, abs(d)));

  // bounding box
  if (vPosition.x > PITCHING_DISTANCE || vPosition.x < -0.694 || abs(vPosition.z) > 1.28) {
    gl_FragColor = vec4(c, c, c, 1.0);
    return;
  }

  float pitch0Shadow = 0.1;
  float pitch1Shadow = 0.1;
  float pitch2Shadow = 0.1;

  // pitch shadows
  for (int i = 0; i < 9; ++i) {
    if (enabled[0]) pitch0Shadow = min(pitch0Shadow, sdfSegment(vPosition.xz, pitch0[i].xz, pitch0[i + 1].xz));
    if (enabled[1]) pitch1Shadow = min(pitch1Shadow, sdfSegment(vPosition.xz, pitch1[i].xz, pitch1[i + 1].xz));
    if (enabled[2]) pitch2Shadow = min(pitch2Shadow, sdfSegment(vPosition.xz, pitch2[i].xz, pitch2[i + 1].xz));
  }

  float r = (mix(c, 0.78, smoothstep(0.1, 0.0, pitch0Shadow)) + mix(c, 0.18, smoothstep(0.1, 0.0, pitch1Shadow)) + mix(c, 0.08, smoothstep(0.1, 0.0, pitch2Shadow))) / 3.0;
  float g = (mix(c, 0.16, smoothstep(0.1, 0.0, pitch0Shadow)) + mix(c, 0.49, smoothstep(0.1, 0.0, pitch1Shadow)) + mix(c, 0.40, smoothstep(0.1, 0.0, pitch2Shadow))) / 3.0;
  float b = (mix(c, 0.16, smoothstep(0.1, 0.0, pitch0Shadow)) + mix(c, 0.20, smoothstep(0.1, 0.0, pitch1Shadow)) + mix(c, 0.75, smoothstep(0.1, 0.0, pitch2Shadow))) / 3.0;

  gl_FragColor = vec4(r, g, b, 1.0);
}
