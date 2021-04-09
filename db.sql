PGDMP                 	        y           slr    13.1    13.1 ,    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16738    slr    DATABASE     h   CREATE DATABASE slr WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE slr;
                postgres    false            �            1259    16739    architectures    TABLE     �   CREATE TABLE public.architectures (
    id uuid NOT NULL,
    reader_description character varying NOT NULL,
    paper_id uuid NOT NULL,
    name character varying NOT NULL,
    author_description character varying
);
 !   DROP TABLE public.architectures;
       public         heap    postgres    false            �           0    0 '   COLUMN architectures.author_description    COMMENT     �   COMMENT ON COLUMN public.architectures.author_description IS 'This field is different from reader_description : content must be extracted from the paper (copy/paste description), rather than explained from our knowledge';
          public          postgres    false    200            �            1259    16819    components_base    TABLE     �   CREATE TABLE public.components_base (
    id uuid NOT NULL,
    name character varying NOT NULL,
    base_description character varying
);
 #   DROP TABLE public.components_base;
       public         heap    postgres    false            �            1259    16745    components_instances    TABLE     �   CREATE TABLE public.components_instances (
    id uuid NOT NULL,
    name character varying NOT NULL,
    architecture_id uuid NOT NULL,
    reader_description character varying,
    author_description character varying,
    component_base_id uuid
);
 (   DROP TABLE public.components_instances;
       public         heap    postgres    false            �            1259    16751    connections    TABLE     �   CREATE TABLE public.connections (
    id uuid NOT NULL,
    first_component uuid NOT NULL,
    second_component uuid NOT NULL
);
    DROP TABLE public.connections;
       public         heap    postgres    false            �            1259    25038    invite_tokens    TABLE     L   CREATE TABLE public.invite_tokens (
    token character varying NOT NULL
);
 !   DROP TABLE public.invite_tokens;
       public         heap    postgres    false            �            1259    16754    papers    TABLE     �  CREATE TABLE public.papers (
    id uuid NOT NULL,
    name character varying NOT NULL,
    doi character varying,
    authors character varying NOT NULL,
    paper_type character varying,
    journal character varying,
    added_by character varying NOT NULL,
    updated_by character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    abstract character varying,
    comments character varying
);
    DROP TABLE public.papers;
       public         heap    postgres    false            �            1259    16811    properties_base    TABLE     �   CREATE TABLE public.properties_base (
    id uuid NOT NULL,
    key character varying NOT NULL,
    component_base_id uuid NOT NULL
);
 #   DROP TABLE public.properties_base;
       public         heap    postgres    false            �            1259    16761    properties_instances    TABLE     �   CREATE TABLE public.properties_instances (
    id uuid NOT NULL,
    key character varying NOT NULL,
    value character varying NOT NULL,
    component_instance_id uuid,
    is_default boolean DEFAULT false NOT NULL,
    property_base_id uuid
);
 (   DROP TABLE public.properties_instances;
       public         heap    postgres    false            �            1259    25013    users    TABLE       CREATE TABLE public.users (
    username character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    role character varying NOT NULL,
    is_admin boolean NOT NULL,
    hash character varying NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �          0    16739    architectures 
   TABLE DATA           c   COPY public.architectures (id, reader_description, paper_id, name, author_description) FROM stdin;
    public          postgres    false    200   �7       �          0    16819    components_base 
   TABLE DATA           E   COPY public.components_base (id, name, base_description) FROM stdin;
    public          postgres    false    206   �8       �          0    16745    components_instances 
   TABLE DATA           �   COPY public.components_instances (id, name, architecture_id, reader_description, author_description, component_base_id) FROM stdin;
    public          postgres    false    201   �:       �          0    16751    connections 
   TABLE DATA           L   COPY public.connections (id, first_component, second_component) FROM stdin;
    public          postgres    false    202   -B       �          0    25038    invite_tokens 
   TABLE DATA           .   COPY public.invite_tokens (token) FROM stdin;
    public          postgres    false    208   �D       �          0    16754    papers 
   TABLE DATA              COPY public.papers (id, name, doi, authors, paper_type, journal, added_by, updated_by, status, abstract, comments) FROM stdin;
    public          postgres    false    203   �D       �          0    16811    properties_base 
   TABLE DATA           E   COPY public.properties_base (id, key, component_base_id) FROM stdin;
    public          postgres    false    205   �K       �          0    16761    properties_instances 
   TABLE DATA           s   COPY public.properties_instances (id, key, value, component_instance_id, is_default, property_base_id) FROM stdin;
    public          postgres    false    204   L       �          0    25013    users 
   TABLE DATA           V   COPY public.users (username, first_name, last_name, role, is_admin, hash) FROM stdin;
    public          postgres    false    207   �P       K           2606    16768     architectures architectures_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT architectures_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.architectures DROP CONSTRAINT architectures_pkey;
       public            postgres    false    200            ]           2606    16826 $   components_base components_base_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.components_base
    ADD CONSTRAINT components_base_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.components_base DROP CONSTRAINT components_base_pkey;
       public            postgres    false    206            N           2606    16770 $   components_instances components_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT components_pkey;
       public            postgres    false    201            a           2606    25045     invite_tokens invite_tokens_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.invite_tokens
    ADD CONSTRAINT invite_tokens_pkey PRIMARY KEY (token);
 J   ALTER TABLE ONLY public.invite_tokens DROP CONSTRAINT invite_tokens_pkey;
       public            postgres    false    208            V           2606    16772    papers papers_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.papers DROP CONSTRAINT papers_pkey;
       public            postgres    false    203            [           2606    16818 $   properties_base properties_base_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.properties_base
    ADD CONSTRAINT properties_base_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.properties_base DROP CONSTRAINT properties_base_pkey;
       public            postgres    false    205            Y           2606    16774 $   properties_instances properties_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.properties_instances
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.properties_instances DROP CONSTRAINT properties_pkey;
       public            postgres    false    204            T           2606    16776    connections relations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.connections DROP CONSTRAINT relations_pkey;
       public            postgres    false    202            _           2606    25020    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    207            O           1259    16777    fki_archConstraint    INDEX     `   CREATE INDEX "fki_archConstraint" ON public.components_instances USING btree (architecture_id);
 (   DROP INDEX public."fki_archConstraint";
       public            postgres    false    201            W           1259    16778    fki_compConstraint    INDEX     f   CREATE INDEX "fki_compConstraint" ON public.properties_instances USING btree (component_instance_id);
 (   DROP INDEX public."fki_compConstraint";
       public            postgres    false    204            P           1259    25012    fki_componentBaseConstraint    INDEX     k   CREATE INDEX "fki_componentBaseConstraint" ON public.components_instances USING btree (component_base_id);
 1   DROP INDEX public."fki_componentBaseConstraint";
       public            postgres    false    201            Q           1259    16779    fki_first_component_constraint    INDEX     a   CREATE INDEX fki_first_component_constraint ON public.connections USING btree (first_component);
 2   DROP INDEX public.fki_first_component_constraint;
       public            postgres    false    202            L           1259    16780    fki_paperConstraint    INDEX     S   CREATE INDEX "fki_paperConstraint" ON public.architectures USING btree (paper_id);
 )   DROP INDEX public."fki_paperConstraint";
       public            postgres    false    200            R           1259    16781    fki_second_component_constraint    INDEX     c   CREATE INDEX fki_second_component_constraint ON public.connections USING btree (second_component);
 3   DROP INDEX public.fki_second_component_constraint;
       public            postgres    false    202            c           2606    16782 +   components_instances architectureConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT "architectureConstraint" FOREIGN KEY (architecture_id) REFERENCES public.architectures(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 W   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT "architectureConstraint";
       public          postgres    false    200    2891    201            g           2606    16787 #   properties_instances compConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.properties_instances
    ADD CONSTRAINT "compConstraint" FOREIGN KEY (component_instance_id) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 O   ALTER TABLE ONLY public.properties_instances DROP CONSTRAINT "compConstraint";
       public          postgres    false    2894    204    201            d           2606    25007 ,   components_instances componentBaseConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT "componentBaseConstraint" FOREIGN KEY (component_base_id) REFERENCES public.components_base(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 X   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT "componentBaseConstraint";
       public          postgres    false    201    206    2909            e           2606    16792 $   connections firstComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "firstComponentConstraint" FOREIGN KEY (first_component) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 P   ALTER TABLE ONLY public.connections DROP CONSTRAINT "firstComponentConstraint";
       public          postgres    false    2894    202    201            b           2606    16797    architectures paperConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT "paperConstraint" FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 I   ALTER TABLE ONLY public.architectures DROP CONSTRAINT "paperConstraint";
       public          postgres    false    203    200    2902            f           2606    16802 %   connections secondComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "secondComponentConstraint" FOREIGN KEY (second_component) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 Q   ALTER TABLE ONLY public.connections DROP CONSTRAINT "secondComponentConstraint";
       public          postgres    false    201    2894    202            �   �   x���;n�0Dk�� E�� ]ҥ�(
^ Y���#����|3Clq�2 9�A�"���īN�|��e��*�}W�vs.j6�t�L��F�"$��i�B��EB筵�2���e�M�C�~����sr���!!��
t0h��C��m�h�9������ H�Bm,`�M"M���P!�(��S�1��f�Rj�bke|$�wuz?��>�S�����z;�W�6�����2���
�0      �   �  x�u��r�0�k�S���^��I�I�s��Z㬔����>�k��>���0+R��� ���5x�-���rs���u����Лy\���l�c^��M�KSf�`�:GP�x@�s�$5O*�m>ަۺ�Ǻ��J�^�k�8w�B�Bʑ+	�4�h�s�m��z
	0� �d0*jt��G1_I^�����='���8���j�>�\Ț�mȺ�1]uэ>�ȱ�X��f��B��j��S�����������
ڨÑ�T(~�(�a�C�_z�����������5(����Yd`/�ΎjY�G�}�tig �S�<T�H:��@�Sy�%��*���r���Ӧ\��k��mtPu쯢H��V����66C]?��,��	0c5R�R}�	G�1~l�i?���ITȜFC�ݘ�㇨�i)c��o���xy�r�\����      �   m  x��W]o��|�~�`_� c�9|ܽ�%d/��y����K��������P�Z{��Yΐ���UM�M!E���7Tҵ�>�lUԍ�|Ҏ6ҊVR�2[u�܇6q�5%ۤ�6���~b�aߥ��6���3;�1h�qbeY`%L3i;��l(l��a���2Mi�s7���ۍ�r���7�j]j�lY�")���I�7AYnD@��N�i(�I�ͿN4>�C��=����m�'�׳�w��(;M4��_�a���Dv��ryz��e#�j=QKn������֤�h���i+#2,�r��iB1<F!�jCC.�"�ڼ��!���R�8#Ml:�q�	�CMnޅ��hd��ﰇ�0d�^�@e�-�%o���,osh�����:Ǡ4��C��0�0e���B�&�܍C�i��{v£_��?����~��>)�7����C�77l]y.L��R������{@�F��O��?O4��+��Nc7?]p�a���$��g!��.�*��ʺD���s�+�4�K�x����"ª8[�x#ppxPA�T(�!����"�bynbG���}J:��*���'��y�9���P3�4R2���$�MnP%W�����S��Gt,;t���EbH���|�~�u�9���y����c�Ka��3P�~�*�0�i���<�	@���~�ݧ�gN��}�� o�%H�JM�q���yK�+�u*����e d)r�6p�Y��>$鯛�U��{��T�	�0�O��7�(#���y���~���.L;@�ݲ�#r�L`?��q�qG/�us���5�+��C�����*2���=vu�C���jE~وB�~{'7>�lZ͛F��}t<�Y�F{�:R�|��b�^i����N�Q��EU���i���V��Df��7�����4�$bS�H��:���_ޥ��W����_΋�T����N�n����W�YN>m픊�����JCE%� �1`{(�!���}[_�hb�o(��`�Ϡ|V�I!H_��/�*~���↧>S�z�q����KUk���4����� ������ڋ��>�%L���tZ{X�ZU�6Ĵ#�mQ��L�b$�k���gc��)���e���B��ke��l,�Z6<{��\s�����	��iZ$�-@�,rv�:�<+�����J!{���sAc
r�56��'���)/���h��!b"�rn�R�_�?�!-�@O�NX���:p[8$eq�X�x̑�ܒ��)kE�Vy]�V�9�#x��)Z5�`�.Ջ���+��¨s��3�?;~��%gnX����?y�Ҍ::\��:��~��@�n�������ܲ_�7�(l��*��q��>,a����&ƅ����O߁t�q���a����D��(�i�zd��0���m�f5/����݀�Ʈ�-�l�3wwZl0	Z;��iZ��j�k���o߼Ȟ���d�����U��U���8ʲ�d� ���Y�1�-)�2�K��*����Fƴ�fHש�ٵ8�ʾ���#�p�U�ؑ�����V��� =_��y��ʺ�+��'�[���X�o]Ī��cS�x�K��b4���x�:�p�|i�ź�Y�����]�: ����	���썙�N77P��0.,��sW.6�}Z�-��%L���f�k��Pi���ˋ�e֙&p-A)oe}�IJ-����X�-y�� ��Ά��m6	� ���qx)����h��#02�ąMJ9�"�y����L�x�)�X/ZXR�7V�a�.lE���L�y4�x,0*�B�c��Um*�J�b���M�b�՞C�[͓�q��=�������W�_5�r��n��$D      �   �  x����$!E�=��� ����a鍠/]����_��Ƶ�-.L�}��Nɜ6�E�k�ceI�p���ڐ���q)���ABI7��I��m��#��	���R�h���/)"m�_���$�x(���Eμ�M-������+�&LW��dz�#Oy_�����N��y6��or6㊰CG���=u�CC�Tm?gU��Pl���9&�{�6�:_�I�ٷ9?����N�m���JN=���U��},�f_d��Ӊxtx���d���)u9X���`���ru��p������.��m��5f}��9���¼���۟��{#���W���0u��{��1i]��9FMυz@N�#5z������7�/A�R$?�a�V����XY���n<ψX�6�m�N��i��
�c�7��X���x߽�q!�2��ѓ:6?��p�Ӱ��(R'������z���+g��/�aYƖ�� wS��AP{����N�;�M��u~�Z��r��F���*	�$4H���ܧ�ԙ�no�4���`o���@M�i�|�N����]N��Nמ�$z܇]�X�d�^9*j�)
;�S��<q�|�b��yR�~�bu���m�1r���ӯ���qڂ�61��|�:}
�Vݧ�������|�g      �      x������ � �      �   �  x��W]o7|V~���"Yvl=��h�6M
H+�#�#�$O���;˽��qǑ������pu}y�X�,/&�����f5Y��dvqyAz���f�7�&�M�^S&uWS�~��6�����5Y���ΐ˵�hF��t>�]?_^�L�7��|1���_M��,�?�+3Vw��S��>t[������my�
�c�:tіg�u�ɕg>ّ�mژ
)���?Gxx/��/�b����Qa��P���7�6��"]���ƚ���Zu�eEYEjm�R��Rjm7�;(�v��P�"�q�y��lcE�"����cڔ:���Q�F,hML�����T����%�V{�PYv�N(>p�d4RP������Sٝ��X,�i'�p�&G+��X�$���!Vi�>vQ�Cʦ��c8�l��J����6�w����Ȗx
)q
�P2+�[ �؜+��ب�		�H�S��?X*�D�އ^#uAIM=�Rp]i�꠺�76@���b2��������&�Cܪu���$�9ÛV!�\�Sq�^s�ޤ��H�D+Yq@^�RD����ĝ�fȨ����T�vJ��Xex�I��Ъ�N}� �?h;�&��㼞�h�h��&��Z�Д`N�X>e�y��W;���0|����z!��In����X�ikX�?�M�=N�vCC�R׶��0Q���,��}�0���E~��h}6�δ��P�3����X\�x��^�U=Y����q�.)�#5f`����s°s����g����B3���o�7W����l��	k��!�J�wvM�X�i���8u F�~�#���8�-�\9��P-���ş��_���I�����_Y��5^�$U y"��*~�`�X�UڎM����׾�U(��a&޵�a/
ك��3��5U1��r���z�u�>�����ETf��d��������x(/�9h�1�$���s�iְ�R�e�*���+��qn�V	� ��d�A0wLo(S��;��6\��1��MM� ��?@�C��=�O����h�d7ޢb���+a����}Fd�R�!�\�0�}m!Pݚ�Oo@ɺг�~fT)�DR;r���-�D�k��|E����!��l���U7���r2iX'v1�"ܼb������eb�b�=��/F��й��GB�ߋ�?��/�jZB	��%[���)O`���r�֦����9&o��m�cـ�
e��?��1��g���X�r��Q��n�:�WF˭,�j�v�ÄV�Ȍdr0������$�F�}B�2:U��=��6m��%�p���$�rB��wgZ�=�8U��CǓ��.H�	��8�
���!�<���*�	�~�ٞU��%Y�L�(|�S�9V��zq1���`��q0�pcxh:��=�s�S�7��D������b1[ή/���r����ۺ���u'.�y�ùo(5������(�$^8Xi!$�k��Q�y��N�<9��D��G��S2�(
�GlB��E�F�#}8���{KsN�q��|��e�y�>Y�I���wh@�F3ǩz)W@��QƎ�q��ڬ�E�܌!��2dWF��m�h����c E?>���yJ�� ]y����L���WWpOj��]=$��9r�̢���\a�/�Ai��`��X���ee�o������������"�`O(_'�;R�:�u?��wu�1!�_�C��~�^6�F�F:��+��_��Vw���������g���e      �      x������ � �      �   �  x��V�nG<��b�	����Ə�9� _zfzDBԮB.0_�ZQ��0L��%1;�]]U��TV�t&WR��l'	��*>V�� ����4�5�p�P��:��BE3�ئ{OڋNC>}��nRk�RNڑ3�S��P�F�z�l���t��p<������e�0�����"m���s'|n����v�$[Hz�䢲T����8Ӳ�V��'�J9=�1���a�]U���N����T�eW�� 5�\�����nT�eB����3y�o�ݎ?��ُ7;�d��i|���x{:,���P�4�s%S��$l#n�-7�kK��Pϰ-kvX��􄓢I삘�|�U�eϻ��҆���\�P}�8I9���J�T�:4bKf�������rz������q[��^�t�}�=t�$�DI�%1�z�6���>m���ë�ҏ����F��d�UB�-�F.%4�3^�0�}S�۩�O��v���t	�����c�l91�@Aqoɷh��n���/2���x{5^��~;ݍ�q��J�����󔬎Ԓ�Js��3h�YEc�c	ҏ��B�lem0[��p=O�v��O�B���e�y��^�O�0��uʡp"cY��(����gBW�ܬei�@�DPa��T��2�5:���q�lwr�m�����x�-#3�x�l,���T�Vp(@�N��R���Y�F��~��y���6�+�΂6#�s�l�N�륤6�>�~�:�Ϊ�'�W�n�ݶ��������̫�e�F�2 �e�䌧Zk�1S�*��I�.eeL�(�7�j:����]�RB��IJF��R�&�9J(�kX��VS5"�Z�Fb�T�[0�b�/i�v��^��y�H�y&��g�f�B��f+좣}����p��^��5� 4�����h�U���f��ws���Ng��0�3��&yX�������?�d6��
O�GUT*ux�Ӹ"����|/�4��(��c7�L=
�#�c5:�? PNX/ހX��`Bi<Ku�^�p�	���ٗ��_�;������i�v;�N�<��Ȇ�#dF#A�gĖ���.������n.[B��`P�Z��h��*[q���1�O@�`ŪW�,]u�9��_H�W�ݲ9��(x^Daр���!����b�����)��ZgI�����(��(���o�"��������M��,��G������?;N��      �   i   x��+ά���L��I,��2�\��KJSR�J8K8U��TT������3}|�£��B��}�|���
+�Ͳ��3���<,J+|3-}������<s�b���� ,ID     