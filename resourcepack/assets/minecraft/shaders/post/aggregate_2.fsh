#version 150

uniform sampler2D InSampler;
uniform vec2 InSize;
uniform float Step;

in vec2 texCoord;
flat in vec2 oneTexel;

out vec4 outColor;

void main() {
    outColor = texture(InSampler, texCoord);
    float width = ceil(InSize.x / Step);
    vec2 samplepos = gl_FragCoord.xy - 0.5;
    samplepos = vec2(samplepos.x - width, samplepos.y * Step);
    if (samplepos.x >= 0.0 && samplepos.x < width && samplepos.y < InSize.y) {
        float tmpCounter = 0.0;
        for (int i = 0; i < int(Step); i += 1) {
            tmpCounter += float(texture(InSampler, (vec2(samplepos.x, samplepos.y + float(i)) + 0.5) * oneTexel).b * 255.0);
        }
        tmpCounter /= 255.0;
        outColor = vec4(vec3(tmpCounter), 1.0);
    }
}