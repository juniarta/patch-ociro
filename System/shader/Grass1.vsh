vs.1.1
;------------------------------------------------------------------------------
; c0-c3 ��Ʈ���� 1 
; c4-c7 ��Ʈ���� 2
; c8	����
; c9  x=����ġ ,y=����
; c12- ���ؽ� ���̴��� ��Ȳ�� ���� ����.
;
; Vertex components 
;    v0    = Position
;------------------------------------------------------------------------------

dcl_position0	v0
dcl_color	v3
dcl_texcoord0	v4
;------------------------------------------------------------------------------
; Vertex transformation
;------------------------------------------------------------------------------

; Transform to view space (world matrix is identity)
m4x4 r9, v0, c0	

; ���� �κ��̴�.
mul r10.x,v0.y,c9.x
add r9.x,r9.x,r10.x

; Transform to projection space
m4x4 r10, r9, c4

; Store output position
mov oPos, r10	
mov oD0, v3    ;�÷� ���� �ִ´�.
mov oD0.w,c9.y		;//���� ����

;------------------------------------------------------------------------------
; Texture coordinates
;------------------------------------------------------------------------------

; Copy tex coords
mov oT0.xy, v4



;------------------------------------------------------------------------------
; Fog calculation
;------------------------------------------------------------------------------
; compute fog factor f = (fog_end - dist)*(1/(fog_end-fog_start))
add r0.x, -r9.z, c8.y
mul r0.x, r0.x, c8.z
max r0.x, r0.x, c9.z       ; clamp fog to > 0.0
min oFog, r0.x, c9.w     ; clamp fog to < 1.0

;mov oFog.x,c10.x

