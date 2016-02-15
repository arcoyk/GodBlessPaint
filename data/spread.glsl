#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float timer;

varying vec4 vertColor;
varying vec4 vertTexCoord;

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void) {
  // skip random pixel
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
  vec4 col4 = texture2D(texture, tc4);
  if (mod(rand(gl_FragCoord.xy), 2.0) < 1.0) {
    // coordinates of surrounded pixels around focused pixcel (= vertTexCoord)
    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
    vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
    vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
    vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

    // colors of each pixcel
    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);

    if (col4 == vec4(1.0, 1.0, 1.0, 1.0)) {

      float cnt = 0.0;
      vec4 average = vec4(0.0, 0.0, 0.0, 1.0);

      if (col0 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col0;
        cnt += 1.0;
      }
      if (col1 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col1;
        cnt += 1.0;
      }
      if (col2 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col2;
        cnt += 1.0;
      }
      if (col3 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col3;
        cnt += 1.0;
      }
      if (col5 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col5;
        cnt += 1.0;
      }
      if (col6 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col6;
        cnt += 1.0;
      }
      if (col7 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col7;
        cnt += 1.0;
      }
      if (col8 != vec4(1.0, 1.0, 1.0, 1.0)) {
        average += col8;
        cnt += 1.0;
      }

      if (cnt != 0.0) {
        col4 = vec4( average.rgb / (float(cnt)), 1.0);
      }
      gl_FragColor = col4;
    }
  } else {
    gl_FragColor = col4;
  }
}
