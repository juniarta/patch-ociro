
vs.1.1
;------------------------------------------------------------------------------
; c0-c3 ��Ʈ���� 1 
; c4-c7 ��Ʈ���� 2
; c8	����
; c9  x=����ġ ,y=����
; c10  	�ٴ��÷� 
; c12- ���ؽ� ���̴��� ��Ȳ�� ���� ����.
;
; Vertex components 
;    v0    = Position
;------------------------------------------------------------------------------

dcl_position0	v0
dcl_color		v6
dcl_texcoord0	v3

;------------------------------------------------------------------------------
; Vertex transformation
;------------------------------------------------------------------------------

; Transform to view space (world matrix is identity)
m4x4 r9, v0, c0	

; Transform to projection space
m4x4 r10, v0, c4

; Store output position
mov oPos, r10	

;mul oD0,v6,c10       ;Diffuse *�ٴ��÷�
;mov oD0.w,c9.y		;//���� ����
;mov oD0, v6    ;�÷� ���� �ִ´�.
mov oD0, c10    ;�÷� ���� �ִ´�.
mov oD1, c10    ;�÷� ���� �ִ´�.
;------------------------------------------------------------------------------
; Texture coordinates
;------------------------------------------------------------------------------

; Copy tex coords
mov oT0.xy, v3

dp4 r0.x, v0, c14
dp4 r0.y, v0, c15
dp4 r0.z, v0, c16

rcp r0.z, r0.z
mad oT1.x,r0.x,r0.z,c11.w
mad oT1.y,r0.y,r0.z,c11.z


;mul r9,c11,r10
;add r9.x,r9.x,c11.z
;add r9.y,r9.y,c11.w
;mov oT1.x,r9.x
;mov oT1.y,r9.y


;------------------------------------------------------------------------------
; Fog calculation
;------------------------------------------------------------------------------
; compute fog factor f = (fog_end - dist)*(1/(fog_end-fog_start))
add r0.x, -r9.z, c8.y
mul r0.x, r0.x, c8.z
max r0.x, r0.x, c9.z       ; clamp fog to > 0.0
min oFog, r0.x, c9.w     ; clamp fog to < 1.0

;mov oFog.x,c10.x

