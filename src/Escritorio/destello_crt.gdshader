shader_type canvas_item;

uniform vec4 color_del_destello : source_color = vec4(0.75, 1.0, 0.82, 1.0);
uniform float apertura : hint_range(0.0, 1.0) = 0.0;
uniform float brillo : hint_range(0.0, 1.0) = 0.0;
uniform float grosor_minimo : hint_range(0.0, 0.1) = 0.006;
uniform float suavizado_del_borde : hint_range(0.0, 0.2) = 0.03;

void fragment() {
	float distancia_al_centro = abs(UV.y - 0.5) * 2.0;
	float limite = max(apertura, grosor_minimo);
	float dentro_del_destello = 1.0 - smoothstep(limite - suavizado_del_borde, limite, distancia_al_centro);
	COLOR = vec4(color_del_destello.rgb, dentro_del_destello * brillo);
}
