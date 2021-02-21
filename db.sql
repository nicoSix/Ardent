PGDMP     0                    y            slr    13.1    13.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16531    slr    DATABASE     h   CREATE DATABASE slr WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE slr;
                postgres    false            �            1259    16532    architectures    TABLE     ,  CREATE TABLE public.architectures (
    id uuid NOT NULL,
    paper character varying NOT NULL,
    description character varying NOT NULL,
    done_by character varying,
    added_by character varying,
    status character varying,
    paper_id uuid NOT NULL,
    name character varying NOT NULL
);
 !   DROP TABLE public.architectures;
       public         heap    postgres    false            �            1259    16538 
   components    TABLE     �   CREATE TABLE public.components (
    id uuid NOT NULL,
    name character varying NOT NULL,
    architecture_id uuid NOT NULL,
    description character varying
);
    DROP TABLE public.components;
       public         heap    postgres    false            �            1259    16544    connections    TABLE     �   CREATE TABLE public.connections (
    id uuid NOT NULL,
    first_component uuid NOT NULL,
    second_component uuid NOT NULL
);
    DROP TABLE public.connections;
       public         heap    postgres    false            �            1259    16585    papers    TABLE     z  CREATE TABLE public.papers (
    id uuid NOT NULL,
    name character varying NOT NULL,
    doi character varying,
    authors character varying NOT NULL,
    paper_type character varying,
    journal character varying,
    added_by character varying NOT NULL,
    updated_by character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    abstract character varying
);
    DROP TABLE public.papers;
       public         heap    postgres    false            �            1259    16547 
   properties    TABLE     �   CREATE TABLE public.properties (
    id uuid NOT NULL,
    key character varying NOT NULL,
    value character varying NOT NULL,
    component_id uuid
);
    DROP TABLE public.properties;
       public         heap    postgres    false            �          0    16532    architectures 
   TABLE DATA           j   COPY public.architectures (id, paper, description, done_by, added_by, status, paper_id, name) FROM stdin;
    public          postgres    false    200   �#       �          0    16538 
   components 
   TABLE DATA           L   COPY public.components (id, name, architecture_id, description) FROM stdin;
    public          postgres    false    201   I*       �          0    16544    connections 
   TABLE DATA           L   COPY public.connections (id, first_component, second_component) FROM stdin;
    public          postgres    false    202   0       �          0    16585    papers 
   TABLE DATA           u   COPY public.papers (id, name, doi, authors, paper_type, journal, added_by, updated_by, status, abstract) FROM stdin;
    public          postgres    false    204   �2       �          0    16547 
   properties 
   TABLE DATA           B   COPY public.properties (id, key, value, component_id) FROM stdin;
    public          postgres    false    203   �8       6           2606    16554     architectures architectures_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT architectures_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.architectures DROP CONSTRAINT architectures_pkey;
       public            postgres    false    200            9           2606    16556    components components_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.components DROP CONSTRAINT components_pkey;
       public            postgres    false    201            C           2606    16592    papers papers_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.papers DROP CONSTRAINT papers_pkey;
       public            postgres    false    204            A           2606    16558    properties properties_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.properties DROP CONSTRAINT properties_pkey;
       public            postgres    false    203            >           2606    16560    connections relations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.connections DROP CONSTRAINT relations_pkey;
       public            postgres    false    202            :           1259    16561    fki_archConstraint    INDEX     V   CREATE INDEX "fki_archConstraint" ON public.components USING btree (architecture_id);
 (   DROP INDEX public."fki_archConstraint";
       public            postgres    false    201            ?           1259    16562    fki_compConstraint    INDEX     S   CREATE INDEX "fki_compConstraint" ON public.properties USING btree (component_id);
 (   DROP INDEX public."fki_compConstraint";
       public            postgres    false    203            ;           1259    16563    fki_first_component_constraint    INDEX     a   CREATE INDEX fki_first_component_constraint ON public.connections USING btree (first_component);
 2   DROP INDEX public.fki_first_component_constraint;
       public            postgres    false    202            7           1259    16599    fki_paperConstraint    INDEX     S   CREATE INDEX "fki_paperConstraint" ON public.architectures USING btree (paper_id);
 )   DROP INDEX public."fki_paperConstraint";
       public            postgres    false    200            <           1259    16564    fki_second_component_constraint    INDEX     c   CREATE INDEX fki_second_component_constraint ON public.connections USING btree (second_component);
 3   DROP INDEX public.fki_second_component_constraint;
       public            postgres    false    202            E           2606    16565 !   components architectureConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.components
    ADD CONSTRAINT "architectureConstraint" FOREIGN KEY (architecture_id) REFERENCES public.architectures(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 M   ALTER TABLE ONLY public.components DROP CONSTRAINT "architectureConstraint";
       public          postgres    false    2870    200    201            H           2606    16570    properties compConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.properties
    ADD CONSTRAINT "compConstraint" FOREIGN KEY (component_id) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 E   ALTER TABLE ONLY public.properties DROP CONSTRAINT "compConstraint";
       public          postgres    false    201    203    2873            F           2606    16575 $   connections firstComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "firstComponentConstraint" FOREIGN KEY (first_component) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 P   ALTER TABLE ONLY public.connections DROP CONSTRAINT "firstComponentConstraint";
       public          postgres    false    2873    201    202            D           2606    16594    architectures paperConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT "paperConstraint" FOREIGN KEY (paper_id) REFERENCES public.papers(id) NOT VALID;
 I   ALTER TABLE ONLY public.architectures DROP CONSTRAINT "paperConstraint";
       public          postgres    false    2883    200    204            G           2606    16580 %   connections secondComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "secondComponentConstraint" FOREIGN KEY (second_component) REFERENCES public.components(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 Q   ALTER TABLE ONLY public.connections DROP CONSTRAINT "secondComponentConstraint";
       public          postgres    false    2873    202    201            �   �  x��WMo�8=;����,�_��c�mќ�@
��ˈ�,"�%);�_�oHIq����^
4E`�3�7ｙܩr������Z[IeQV$��f�����zU�>؆�T���"�ǆ��qұO�!m�}Rdb#ɫ�W�66J�A	W��U�[�E�l�"*�Xg�A� pE��6QP�:]��)�LY}h�YPu�uԊb�q��ƅxԭ6�Et���G<��C�q�+Cq�S>8KF4S��`�Ŏ�8)�y׹������'(�DŐ�}���T����ɦts4��d�4j��h�-��J:_�����"�CT-�@�E�lҵ�W��A���O�$.�(
�$��Z#c�!QڋVULP���!j9$�/�D�ֺ#�F��\h:��S˳���`<����
57>&C��9a#�#�����a��'�D�|�i���&��ҹ{*��J�ѪDK��h�*��:�x��r���QK5VT堞�T��R6(qJ�2_]':��������D=Z�X�v��5�D�]��]e:h�2�<He�̔�{𡚋�0��l�m&O�����\fݳ4��N�>��K�>�ظ�w�93Lԡ�:���Q���$�Wo�6�Dg*����Y���Q�������~�.vk���*�=>)����j�\.׳w^6���jIj�_r+�Ŷ���zU�[u�Ûۻ�n��(��Z^0���¦��l1F�Ĳ�7NϾ p�9�Ȫ�M��B����0U�2�.��	��g槶�N���>7�����Nl�%D��B!㈭��T����#I��Is�uhcD2�J׵�=<���a�s]\�� ��\.N RL��!��\�-L;����P�{��(�m{d�>� s��l4|�R w�dYϧ>d���Y�s@c7����x�=m���`R;�I-�b���:&�p�����qse��|���t��<C|6�"��Q#�c6��>|�#���U�̳�'�!Ճ��CI]�%������5P��0�C�Q���q�J4�ǘ5$���s��y�^d�t]��ge��7�%�T����r�R��b�]��X�UqO{Y���v[W�r����E�"?�p[s�ؿjO���8lGh.�q1�fy�x�v�����ʏ-���s]��B��Z����i�X0+Ӣ�o=Ywʬ9� 2��TU�?�c�DA�&Ħ�+�i~���L*�a<�#�B&>�]�9 yT�' �(��y.���[���s������]n���9�6�:S����O`�'���QӡUg��c�a/	���t^��I��j�`�\Ka��HF�!#��S�bã;��F{����;� 	)�W�љ>���	`8�� ��Po6�/l���j�~ڪ�	����4�{=Xj|�o�������4 ����z�R<�a�����ߔ�ؗKi�-�᷄��@G:�ǺS`Hb���R�.[)�~���RB�6洼�,����7c��L�M�-{t�y����Nb%Ԓ'5������7��Qi��<$�3:[%g@&�&��ɗ1񠳖�����L(�	�$�	��������$��uq�a�<��Z=�&�nX
t�yF�48����Ӹk��l˪��4w&�
$>g�Õw�v�w�����f��oo�8U�w��:�k������U����n�-nnn�Ow;      �   �  x��VM��6=[������!Q_�q&_;�&�L'�%�"Yls-��Hw���oQ�����m�$��ի���A��Z]�mWF!7J���7�N�'�f�W%`3�\7���>��r�b���N����ӑ�=$�^"�Fv�8�X<��K��i��y5$<��=8�c=�sڇɥW�"�?����Qv�(?������e��	N����&*���4�1�`���'J!9�t�?�p���\�Gd��L0���ٱ���O������`��#�i�//�E�L�-���/���pJq����Ü�8:��\z.	}<O8��	�H��%��>��c08�د{�r2�Q��c�Na��x��)��Iu����y�|�����W��DT\U kSY+�+��4}�3���ĥ]1�`��=��/�H0�j��������d��O-}�#a1�O.i���)c���S�	|�Y|�	�������V��g�o3����qW(ї�Z^����岮znd	J*��m��i!p�{peϑ8��+^{�d2RBǷ�ݡ��As�(J�j��TLk���h;=g� �}�|�K�0�K��m;a�s20��}�2`o思'����:j�0�. �u^��iěz�cEkK�`[nzE�Yq�Ps�u�V��>��V�_��cG������O��?�sV�m���3Ɯ�",bE:����iն��K)S��+���ѯ��U���R��%�s㚾��h9��1��˪��Ϊ-�
{�ES	���p	���5��7ߡ��@E���퀯�Q�KE)m�5s��6%�!�l8ھG#-���t����(}W܏:kM������"������l���S�H��Vr�P����jkyM��jDgK�<�>��z������e��t��,��`���`QZ�_$��dy|�j�ueKɟ�4+*�4NDoK���=�Τ�p�S�D��t�yrY���q���;,�F��Z"�Ɗ�A��JԦ6C���㑬�S,"�N�i���Q"�;'^��:�l}�vq�xv�B�S�vH�H-ĸ
���wy$��J�N[ b�Aר6�ʊ�z씰U'n]�B�����9�=��3n�*ʺ�(��4�Vs�:R�D�V��o6_���}9|Ea)��j9}����&e����@�;a�>��-�},�m�^�G��6}�pi�e�h{PI+�l�:"�%�5s3W�ޠu�ȼZ_��en֎���y������b�G�ɢ!�3�����g�{Xn/n�ˮ襪L3Լ�k� �:���x_�Fʺ�����~f�MZQ��7���5��PץŶ,�^5�yx���"�89�a�-핑�Ӈ���t����,�rG�q\]D-��YWf�q���3b:�.w����^��-�����'�]��yj��ז��L��j{��_y���7�"�Q��RIಪ��֕�����އN�ۮ(��6��      �   �  x����$!E�=��� ����a鍠/]����_��Ƶ�-.L�}��Nɜ6�E�k�ceI�p���ڐ���q)���ABI7��I��m��#��	���R�h���/)"m�_���$�x(���Eμ�M-������+�&LW��dz�#Oy_�����N��y6��or6㊰CG���=u�CC�Tm?gU��Pl���9&�{�6�:_�I�ٷ9?����N�m���JN=���U��},�f_d��Ӊxtx���d���)u9X���`���ru��p������.��m��5f}��9���¼���۟��{#���W���0u��{��1i]��9FMυz@N�#5z������7�/A�R$?�a�V����XY���n<ψX�6�m�N��i��
�c�7��X���x߽�q!�2��ѓ:6?��p�Ӱ��(R'������z���+g��/�aYƖ�� wS��AP{����N�;�M��u~�Z��r��F���*	�$4H���ܧ�ԙ�no�4���`o���@M�i�|�N����]N��Nמ�$z܇]�X�d�^9*j�)
;�S��<q�|�b��yR�~�bu���m�1r���ӯ���qڂ�61��|�:}
�Vݧ�������|�g      �     x��WMo7=ۿ����,�M�c�6�/iP�%�wVK�KnI�d����pW�%d��.���{��ww����\������k^_�㛫�������jus�W�(Xn̟T�<v�\ؘ�+�y�}��`����Kg)�ŷO�����d��?�_�L��ІMlMN�}��b��m���� �Y��C�$\c��(Dswn����f[�k�ʘpL�)K��z�)��e	�x��<�Ğ
⅁S����-,�C��c�c3�8Č�cۇ��'�E	���o9�QO㶮����h[�!�%Ok�)��_�tbS����1��υ{9�8,ǡ�!q�!�-"��r&��J�<S�5�' ջR�
	�dzn
8@�"��씸v�Ʌ�x��+J��<�!G?��{3�i�h����jqn�B��^���凉1K��eӓic�+Mb�Ё3rhc.ʞFjVj���)���UI@yo���PcdN[gy���A	�p�X6(Q��Ε�q0��$�3>;ٹ'�b@���h���Ӓ-ٴ)��U���,3ͳ��T��4���L��,��<�N���k��(ҐJ}<|�C���<�<��L4`����<�(��\���G
+�i�<�\^��w�7�o���Yޝ�|�&�%�!��z�D=���5���T�Z�Y빹�ބB�D�g$�X��ff��(���b�;��M�Ũ��SO!�*w�f$̐��Q�ȃ��2�I�C�Q{
6A���D�d�mAI�"���n �S����@R�{�h)`�e��	;L��ɋv�#�4a!�VR��j1@�B��4_pڋsHbsj=j.�Y��jV���9��N��>���z�n:��n�_	y����U.��E�&�]�  4=��3	<;'Bi�#P��u�lɏ��C,"Q�.�ޛ�z�"�@���T{�7�m��V�if!��^��u��f���/.���k�mN.�r��C�Z��T^�՟�<�S��#��s�Gȩ�F��L״��P�}��y!o�J�=�Xӊ�-�P�O��gX~����z[�J�����M�1W�|���ŝzQr2J����q�|�W��%a��C0�gL�Q�@&�����t�Ѣz�Y/a]~�i*J � ���(�0���ى�&�R'�&e��y1c��� 8����8��ړ?��$��%�fQ=�;;���
(�+�yy�nW��͊~��yt���qG���x_�>,K�7Ulr�Xz։o/}�@&�l������kyCTZ�vw<��r/1���B_�_N᪈?Ɲ,d��%�a����D���N�3$�%�?U�PW��1yot�k��9ȩka'k����RC|@��L?gqK��@�z9�,���+6:q~-�<�!]�ԡX���>�1OwZ2@S���K- ����A:���0qQ�6
�kx �@J��	��U�80�,U�z�T'�u{1�;?�j��-��Ϟp��� ��c]�}�������֥[��hDM�N[�t���I^ݤ>�.���Q'W�Ϊy�ʅ^��d	���#l�/�$������/��      �   f  x��UMo#E=��� m�������@�,�¥��:�⌃=�U���I !�#�0�{�U�z�u	Q�NV�)Hi$�Ҕ����4��:�2�χ/�WM-�M}^�L��ب�lx����T�\Tbs$�ْ�����0�t>�O[������az�{��E���x8��f�{���]�B:����'߈��Wo�I��| yz��p\v�)ӔG����X�ƞJk�C�Nm޴�[
=�5�QH����̎�0�/�>^��~�q^�������v{��<�}�vjI�����j@���l�G륺�ڦW�As���(8��TA'��Hk:/G����>}:����-f�C�L0G�PI�Hc�����tßAV煷�ӣN��^mwm9�t�#�i�� �a!�<�k>�u�����Owzz��Y��Ԟe1@��25��)��W�)���l�;C�s�fz?����;��O��B⒌\j`���1�D���%��uL���ͻ߱�t������f{ŧ��|�=��I\6��Hޡ^�!R�6S/��H}���j�s���]g��`\���U}�m�:̻6B�g!�Y۲��[��l��<���i�R�p!�ق����1��I$�4�n�g��AxX���W��̨�3�t�NOۇ�~�=��Ev�;�*u�b�k�"�Fc|����Lj^����Bq҆!�ڽ)��Z��r8������`��'�3q�|�A}"�O7|\�VǴesޞWZn�]WHVS���`7�ΐq �+��1�w8�ipS
5�B��q�e4;5��ɵ_�٬Hj�#�Tt� 1�\�Iܰ��5�,b�y��Z�"�S�=9��߱�~�ӣ"�.�+���^�AcE�ժ�%w�`��+c�Kf�N��C߂`V�_����F����}����w��������ؕG��
,`�3	<)T���"mz��v-����^�R,�Q��w����4(H�zr��,�@��	r�����\�5����#��p)�X*G�}SF0Y�LԵG�w�;��̶6��!�y ��?>�׆,�t.b{���0��6d)����Ƌ�M��9�n�8���	���6;ZM>�WJ�Qy�ܽ��"�߾�l6��m     