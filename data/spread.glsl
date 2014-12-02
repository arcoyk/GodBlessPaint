#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float timer;
uniform float r1, r2, r3;

varying vec4 vertColor;
varying vec4 vertTexCoord;

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void) {
  // Grouping texcoord variables in order to make it work in the GMA 950. See post #13
  // in this thread:
  // http://www.idevgames.com/forums/thread-3467.html


    vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
    vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);
    vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);
    vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);
    vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);
    vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);
    vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);
    vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);
    vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);

    vec4 col0 = texture2D(texture, tc0);
    vec4 col1 = texture2D(texture, tc1);
    vec4 col2 = texture2D(texture, tc2);
    vec4 col3 = texture2D(texture, tc3);
    vec4 col4 = texture2D(texture, tc4);
    vec4 col5 = texture2D(texture, tc5);
    vec4 col6 = texture2D(texture, tc6);
    vec4 col7 = texture2D(texture, tc7);
    vec4 col8 = texture2D(texture, tc8);

    float rr1 = mod(rand(vec2( vertTexCoord.x + r1, vertTexCoord.y + r1)), 0.0002);
    float rr2 = mod(rand(vec2( vertTexCoord.x + r2, vertTexCoord.y + r2)), 0.0002);
    float rr3 = mod(rand(vec2( vertTexCoord.x + r3, vertTexCoord.y + r3)), 0.0002);

  if ( col4 == vec4(1.0, 1.0, 1.0, 1.0) && rand(vec2( vertTexCoord.x + timer, vertTexCoord.y + timer)) * 100.0 < 60.0) {

    float div = 15.0;
    int cnt = 0;
    vec4 average = vec4(0.0, 0.0, 0.0, 1.0);
    float thre = 20.0;

      if (col0 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col0;
          cnt++;
      }
      if (col1 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col1;
          cnt++;
      }
      if (col2 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col2;
          cnt++;
      }
      if (col3 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col3;
          cnt++;      
      }
      if (col4 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col4;
          cnt++;
      }
      if (col5 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col5;
          cnt++;
      }
      if (col6 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col6;
          cnt++;
      }
      if (col7 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col7;
          cnt++;
      }
      if (col8 != vec4(1.0, 1.0, 1.0, 1.0)) {
          average += col8;
          cnt++;
      }

      vec4 res = col4;
      if (cnt != 0) {
        res = vec4( average.rgb / (float(cnt)), 1.0);
        res.r += rr1;
        res.g += rr2;
        res.b += rr3;
      }

      gl_FragColor = vec4(res.rgb, 1.0) * vertColor;
    } else {
      gl_FragColor = vec4(col4.rgb, 1.0) * vertColor;
    }
}
