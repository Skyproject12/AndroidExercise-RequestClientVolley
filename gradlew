package org.d3ifcool.nongkikuy.Preview.Main.Fragment.Beranda;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.StaggeredGridLayoutManager;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.Query;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;

import org.d3ifcool.nongkikuy.Base.BaseFragment;
import org.d3ifcool.nongkikuy.Data.Model.TempatNongkrong;
import org.d3ifcool.nongkikuy.Preview.DetailTempatNongkrong.DetailTempatNongkrongActivity;
import org.d3ifcool.nongkikuy.Preview.Hadiah.HadiahActivity;
import org.d3ifcool.nongkikuy.Preview.Login.LoginActivity;
import org.d3ifcool.nongkikuy.Preview.Promo.PromoActivity;
import org.d3ifcool.nongkikuy.Preview.Rating.RatingActivity;
import org.d3ifcool.nongkikuy.Preview.Registers.RegistersActivity;
import org.d3ifcool.nongkikuy.Preview.SettingAccountPengguna.SettingAccountPenggunaActivity;
import org.d3ifcool.nongkikuy.R;
import org.d3ifcool.nongkikuy.Util.Static;

import java.util.ArrayList;
import java.util.List;

public class BerandaFragment extends BaseFragment implements View.OnClickListener {

    private Toolbar mToolbar;
    private View mView;
    private TextView mTextLogin;
    private LinearLayoutManager mLinearLayoutManager;
    private Button mButtonDaftar;
    private ArrayList<TempatNongkrong> mListRating;
    private RecyclerView mRecyclerRating;
    private ListRatingAdapter mListRatingAdapter;
    private int mJumlahBaris = 2;
    private ArrayList<TempatNongkrong> mListRekomendasi;
    private RecyclerView mRecyclerRekomendasi;
    private ListRekomendasiAdapter mListRekomendasiAdapter;
    private FirebaseUser mPengguna;
    private Handler mBerandaHandler;
    private ConstraintLayout mConstraintPromo;
    private ImageView mImagePromo;
    private TextView mTextPromo;
    private FirebaseFirestore mFirestore;
    private ConstraintLayout mRekomendasiKosong;
    private ImageView mImageRating;
    private TextView mTextRating;
    private ConstraintLayout mConstraintRating;
    private ImageView mImageGift;
    private ConstraintLayout mConstraintGift;
    private TextView mTextGift;
    private TextView mTextJudulRating;
    private TextView mTextDeskripsiRating;
    private DocumentReference mMainRef;
    private static final String TAG = "BerandaFragment";

    public BerandaFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        mView = inflater.inflate(R.layout.fragment_beranda, container, false);
        initial();
        header();
        setRekomendasiTempatRecycler();
        setRatingRecycler();
        goToPromoActivity();
        setRating();
        setGif();
        checkKelengkapanPengguna();
        return mView;

    }

    public void initial() {
        mToolbar = mView.findViewById(R.id.toolbar_main);
        mButtonDaftar = mView.findViewById(R.id.button_daftar);
        mButtonDaftar.setOnClickListener(this);
        mListRating = new ArrayList();
        mRecyclerRating = mView.findViewById(R.id.recycler_rating);
        mListRekomendasi = new ArrayList<>();
        mRecyclerRekomendasi = mView.findViewById(R.id.recycler_rekomendasi);
        mPengguna = FirebaseAuth.getInstance().getCurrentUser();
        mConstraintPromo = mView.findViewById(R.id.constraint_promo);
        mImagePromo = mView.findViewById(R.id.image_promo);
        mTextPromo = mView.findViewById(R.id.text_promo);
        mFirestore = FirebaseFirestore.getInstance();
        mRekomendasiKosong = mView.findViewById(R.id.constraint_rekomendasi_kosong);
        mBerandaHandler = new Handler();
        mImageRating = mView.findViewById(R.id.gambar_rating);
        mTextRating = mView.findViewById(R.id.text_rating);
        mConstraintRating = mView.findViewById(R.id.constraint_rating);
        mImageGift = mView.findViewById(R.id.image_gif);
        mTextGift = mView.findViewById(R.id.text_gif);
        mConstraintGift = mView.findViewById(R.id.constraint_gif);
        mTextJudulRating= mView.findViewById(R.id.text