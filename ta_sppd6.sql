/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     5/6/2025 3:52:06 PM                          */
/*==============================================================*/


drop table if exists daerah;

drop table if exists golongan;

drop table if exists jabatan;

drop table if exists kuitansi;

drop table if exists pegawai;

drop table if exists pengguna;

drop table if exists rpd;

drop table if exists sppd;

drop table if exists spt;

drop table if exists uang_harian;

/*==============================================================*/
/* Table: daerah                                                */
/*==============================================================*/
create table daerah
(
   ID_DAERAH            int not null,
   ID_UANG_HARIAN       int,
   DAERAH               varchar(250),
   primary key (ID_DAERAH)
);

/*==============================================================*/
/* Table: golongan                                              */
/*==============================================================*/
create table golongan
(
   ID_GOLONGAN          int not null,
   GOLONGAN             varchar(25),
   primary key (ID_GOLONGAN)
);

/*==============================================================*/
/* Table: jabatan                                               */
/*==============================================================*/
create table jabatan
(
   ID_JABATAN           int not null,
   JABATAN              varchar(100),
   primary key (ID_JABATAN)
);

/*==============================================================*/
/* Table: kuitansi                                              */
/*==============================================================*/
create table kuitansi
(
   NO_KUITANSI          int not null,
   NIP                  int,
   NO_RPD               int,
   NAMA_PEGAWAI         varchar(250),
   TUJUAN_TUGAS         varchar(250),
   TOTAL_BIAYA          decimal,
   TERBILANG            varchar(250),
   primary key (NO_KUITANSI)
);

/*==============================================================*/
/* Table: pegawai                                               */
/*==============================================================*/
create table pegawai
(
   NIP                  int not null,
   ID_JABATAN           int,
   ID_GOLONGAN          int,
   NAMA_PEGAWAI         varchar(250),
   JABATAN              varchar(100),
   GOLONGAN             varchar(25),
   primary key (NIP)
);

/*==============================================================*/
/* Table: pengguna                                              */
/*==============================================================*/
create table pengguna
(
   EMAIL                varchar(250) not null,
   PASSWORD             varchar(250),
   NAMA_PEGAWAI         varchar(250),
   NAMA_LEVEL           varchar(50),
   primary key (EMAIL)
);

/*==============================================================*/
/* Table: rpd                                                   */
/*==============================================================*/
create table rpd
(
   NO_RPD               int not null,
   NO_SPPD              int,
   NIP                  int,
   NO_KUITANSI          int,
   NAMA_PEGAWAI         varchar(250),
   UANG_HARIAN          decimal,
   TRANSPORTASI_UTAMA   varchar(250),
   HARGA_TRANSPORTASI_UTAMA decimal,
   TRANSPORTASI_LOKAL   varchar(250),
   HARGA_TRANSPORTASI_LOKAL decimal,
   BBM_TOLL             decimal,
   PENGINAPAN           varchar(250),
   HARGA_PENGINAPAN     decimal,
   TOTAL_BIAYA          decimal,
   TERBILANG            varchar(250),
   TUJUAN_TUGAS         varchar(250),
   NOTA                 BLOB,
   primary key (NO_RPD)
);

/*==============================================================*/
/* Table: sppd                                                  */
/*==============================================================*/
create table sppd
(
   NO_SPPD              int not null,
   NO_RPD               int,
   NIP                  int,
   ID_UANG_HARIAN       int,
   NO_SPT               int,
   NAMA_PEGAWAI         varchar(250),
   TUJUAN_TUGAS         varchar(250),
   TEMPAT_BERANGKAT     varchar(250),
   TEMPAT_TUJUAN        varchar(250),
   DAERAH               varchar(250),
   TANGGAL_BERANGKAT    date,
   TANGGAL_KEMBALI      date,
   LAMA_PERJALANAN      numeric(8,0),
   UANG_HARIAN          decimal,
   TRANSPORTASI_UTAMA   varchar(250),
   HARGA_TRANSPORTASI_UTAMA decimal,
   primary key (NO_SPPD)
);

/*==============================================================*/
/* Table: spt                                                   */
/*==============================================================*/
create table spt
(
   NO_SPT               int not null,
   NIP                  int,
   NO_SPPD              int,
   NAMA_PEGAWAI         varchar(250),
   TUJUAN_TUGAS         varchar(250),
   TEMPAT_TUJUAN        varchar(250),
   TANGGAL_BERANGKAT    date,
   TANGGAL_KEMBALI      date,
   primary key (NO_SPT)
);

/*==============================================================*/
/* Table: uang_harian                                           */
/*==============================================================*/
create table uang_harian
(
   ID_UANG_HARIAN       int not null,
   ID_DAERAH            int,
   DAERAH               varchar(250),
   NOMINAL              decimal,
   primary key (ID_UANG_HARIAN)
);

alter table daerah add constraint FK_RELATIONSHIP_13 foreign key (ID_UANG_HARIAN)
      references uang_harian (ID_UANG_HARIAN) on delete restrict on update restrict;

alter table kuitansi add constraint FK_RELATIONSHIP_10 foreign key (NO_RPD)
      references rpd (NO_RPD) on delete restrict on update restrict;

alter table kuitansi add constraint FK_RELATIONSHIP_4 foreign key (NIP)
      references pegawai (NIP) on delete restrict on update restrict;

alter table pegawai add constraint FK_RELATIONSHIP_11 foreign key (ID_JABATAN)
      references jabatan (ID_JABATAN) on delete restrict on update restrict;

alter table pegawai add constraint FK_RELATIONSHIP_12 foreign key (ID_GOLONGAN)
      references golongan (ID_GOLONGAN) on delete restrict on update restrict;

alter table rpd add constraint FK_RELATIONSHIP_3 foreign key (NIP)
      references pegawai (NIP) on delete restrict on update restrict;

alter table rpd add constraint FK_RELATIONSHIP_8 foreign key (NO_SPPD)
      references sppd (NO_SPPD) on delete restrict on update restrict;

alter table rpd add constraint FK_RELATIONSHIP_9 foreign key (NO_KUITANSI)
      references kuitansi (NO_KUITANSI) on delete restrict on update restrict;

alter table sppd add constraint FK_RELATIONSHIP_1 foreign key (NIP)
      references pegawai (NIP) on delete restrict on update restrict;

alter table sppd add constraint FK_RELATIONSHIP_15 foreign key (ID_UANG_HARIAN)
      references uang_harian (ID_UANG_HARIAN) on delete restrict on update restrict;

alter table sppd add constraint FK_RELATIONSHIP_6 foreign key (NO_SPT)
      references spt (NO_SPT) on delete restrict on update restrict;

alter table sppd add constraint FK_RELATIONSHIP_7 foreign key (NO_RPD)
      references rpd (NO_RPD) on delete restrict on update restrict;

alter table spt add constraint FK_RELATIONSHIP_2 foreign key (NIP)
      references pegawai (NIP) on delete restrict on update restrict;

alter table spt add constraint FK_RELATIONSHIP_5 foreign key (NO_SPPD)
      references sppd (NO_SPPD) on delete restrict on update restrict;

alter table uang_harian add constraint FK_RELATIONSHIP_14 foreign key (ID_DAERAH)
      references daerah (ID_DAERAH) on delete restrict on update restrict;

