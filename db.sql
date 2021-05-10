PGDMP     5            
        y           slr    13.1    13.1 )               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    32828    slr    DATABASE     X   CREATE DATABASE slr WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE slr;
                postgres    false            �            1259    32944    answers    TABLE     �   CREATE TABLE public.answers (
    id uuid NOT NULL,
    question_id uuid NOT NULL,
    content character varying NOT NULL,
    username character varying NOT NULL,
    date timestamp with time zone NOT NULL
);
    DROP TABLE public.answers;
       public         heap    postgres    false            �            1259    32829    architectures    TABLE     �   CREATE TABLE public.architectures (
    id uuid NOT NULL,
    reader_description character varying,
    paper_id uuid NOT NULL,
    name character varying NOT NULL,
    author_description character varying
);
 !   DROP TABLE public.architectures;
       public         heap    postgres    false            	           0    0 '   COLUMN architectures.author_description    COMMENT     �   COMMENT ON COLUMN public.architectures.author_description IS 'This field is different from reader_description : content must be extracted from the paper (copy/paste description), rather than explained from our knowledge';
          public          postgres    false    200            �            1259    32835    components_base    TABLE     �   CREATE TABLE public.components_base (
    id uuid NOT NULL,
    name character varying NOT NULL,
    base_description character varying
);
 #   DROP TABLE public.components_base;
       public         heap    postgres    false            �            1259    32841    components_instances    TABLE     �   CREATE TABLE public.components_instances (
    id uuid NOT NULL,
    name character varying NOT NULL,
    architecture_id uuid NOT NULL,
    reader_description character varying,
    author_description character varying,
    component_base_id uuid
);
 (   DROP TABLE public.components_instances;
       public         heap    postgres    false            �            1259    32847    connections    TABLE     �   CREATE TABLE public.connections (
    id uuid NOT NULL,
    first_component uuid NOT NULL,
    second_component uuid NOT NULL
);
    DROP TABLE public.connections;
       public         heap    postgres    false            �            1259    32850    invite_tokens    TABLE     L   CREATE TABLE public.invite_tokens (
    token character varying NOT NULL
);
 !   DROP TABLE public.invite_tokens;
       public         heap    postgres    false            �            1259    32856    papers    TABLE     �  CREATE TABLE public.papers (
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
       public         heap    postgres    false            �            1259    32863    properties_base    TABLE     �   CREATE TABLE public.properties_base (
    id uuid NOT NULL,
    key character varying NOT NULL,
    component_base_id uuid NOT NULL
);
 #   DROP TABLE public.properties_base;
       public         heap    postgres    false            �            1259    32869    properties_instances    TABLE     �   CREATE TABLE public.properties_instances (
    id uuid NOT NULL,
    key character varying NOT NULL,
    value character varying NOT NULL,
    component_instance_id uuid,
    is_default boolean DEFAULT false NOT NULL,
    property_base_id uuid
);
 (   DROP TABLE public.properties_instances;
       public         heap    postgres    false            �            1259    32936 	   questions    TABLE     /  CREATE TABLE public.questions (
    id uuid NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    username character varying NOT NULL,
    date timestamp with time zone NOT NULL,
    object_id uuid,
    object_type character varying,
    status integer NOT NULL
);
    DROP TABLE public.questions;
       public         heap    postgres    false            �            1259    32876    users    TABLE       CREATE TABLE public.users (
    username character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    role character varying NOT NULL,
    is_admin boolean NOT NULL,
    hash character varying NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            x           2606    32951    answers answers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.answers DROP CONSTRAINT answers_pkey;
       public            postgres    false    210            ^           2606    32883     architectures architectures_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT architectures_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.architectures DROP CONSTRAINT architectures_pkey;
       public            postgres    false    200            a           2606    32885 $   components_base components_base_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.components_base
    ADD CONSTRAINT components_base_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.components_base DROP CONSTRAINT components_base_pkey;
       public            postgres    false    201            c           2606    32887 $   components_instances components_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT components_pkey;
       public            postgres    false    202            k           2606    32889     invite_tokens invite_tokens_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.invite_tokens
    ADD CONSTRAINT invite_tokens_pkey PRIMARY KEY (token);
 J   ALTER TABLE ONLY public.invite_tokens DROP CONSTRAINT invite_tokens_pkey;
       public            postgres    false    204            m           2606    32891    papers papers_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.papers DROP CONSTRAINT papers_pkey;
       public            postgres    false    205            o           2606    32893 $   properties_base properties_base_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.properties_base
    ADD CONSTRAINT properties_base_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.properties_base DROP CONSTRAINT properties_base_pkey;
       public            postgres    false    206            r           2606    32895 $   properties_instances properties_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.properties_instances
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.properties_instances DROP CONSTRAINT properties_pkey;
       public            postgres    false    207            v           2606    32943    questions questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            postgres    false    209            i           2606    32897    connections relations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.connections DROP CONSTRAINT relations_pkey;
       public            postgres    false    203            t           2606    32899    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    208            y           1259    32957    fki_answers_to_questions    INDEX     S   CREATE INDEX fki_answers_to_questions ON public.answers USING btree (question_id);
 ,   DROP INDEX public.fki_answers_to_questions;
       public            postgres    false    210            d           1259    32900    fki_archConstraint    INDEX     `   CREATE INDEX "fki_archConstraint" ON public.components_instances USING btree (architecture_id);
 (   DROP INDEX public."fki_archConstraint";
       public            postgres    false    202            p           1259    32901    fki_compConstraint    INDEX     f   CREATE INDEX "fki_compConstraint" ON public.properties_instances USING btree (component_instance_id);
 (   DROP INDEX public."fki_compConstraint";
       public            postgres    false    207            e           1259    32902    fki_componentBaseConstraint    INDEX     k   CREATE INDEX "fki_componentBaseConstraint" ON public.components_instances USING btree (component_base_id);
 1   DROP INDEX public."fki_componentBaseConstraint";
       public            postgres    false    202            f           1259    32903    fki_first_component_constraint    INDEX     a   CREATE INDEX fki_first_component_constraint ON public.connections USING btree (first_component);
 2   DROP INDEX public.fki_first_component_constraint;
       public            postgres    false    203            _           1259    32904    fki_paperConstraint    INDEX     S   CREATE INDEX "fki_paperConstraint" ON public.architectures USING btree (paper_id);
 )   DROP INDEX public."fki_paperConstraint";
       public            postgres    false    200            g           1259    32905    fki_second_component_constraint    INDEX     c   CREATE INDEX fki_second_component_constraint ON public.connections USING btree (second_component);
 3   DROP INDEX public.fki_second_component_constraint;
       public            postgres    false    203            �           2606    32958    answers answers_to_questions    FK CONSTRAINT     �   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_to_questions FOREIGN KEY (question_id) REFERENCES public.questions(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 F   ALTER TABLE ONLY public.answers DROP CONSTRAINT answers_to_questions;
       public          postgres    false    3190    210    209            {           2606    32906 +   components_instances architectureConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT "architectureConstraint" FOREIGN KEY (architecture_id) REFERENCES public.architectures(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 W   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT "architectureConstraint";
       public          postgres    false    3166    200    202                       2606    32911 #   properties_instances compConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.properties_instances
    ADD CONSTRAINT "compConstraint" FOREIGN KEY (component_instance_id) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 O   ALTER TABLE ONLY public.properties_instances DROP CONSTRAINT "compConstraint";
       public          postgres    false    3171    207    202            |           2606    32916 ,   components_instances componentBaseConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.components_instances
    ADD CONSTRAINT "componentBaseConstraint" FOREIGN KEY (component_base_id) REFERENCES public.components_base(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 X   ALTER TABLE ONLY public.components_instances DROP CONSTRAINT "componentBaseConstraint";
       public          postgres    false    201    202    3169            }           2606    32921 $   connections firstComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "firstComponentConstraint" FOREIGN KEY (first_component) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 P   ALTER TABLE ONLY public.connections DROP CONSTRAINT "firstComponentConstraint";
       public          postgres    false    202    3171    203            z           2606    32926    architectures paperConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.architectures
    ADD CONSTRAINT "paperConstraint" FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 I   ALTER TABLE ONLY public.architectures DROP CONSTRAINT "paperConstraint";
       public          postgres    false    3181    200    205            ~           2606    32931 %   connections secondComponentConstraint    FK CONSTRAINT     �   ALTER TABLE ONLY public.connections
    ADD CONSTRAINT "secondComponentConstraint" FOREIGN KEY (second_component) REFERENCES public.components_instances(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 Q   ALTER TABLE ONLY public.connections DROP CONSTRAINT "secondComponentConstraint";
       public          postgres    false    3171    202    203           