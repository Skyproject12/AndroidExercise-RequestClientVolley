package com.example.mysqlvolley;

import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class GithubAdapter extends RecyclerView.Adapter<GithubAdapter.ViewHolder> {
    private User [] list;

    public GithubAdapter(User[] list) {
        this.list = list;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view= LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.item_main, viewGroup, false);
        return  new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder viewHolder, int i) {
        User user= list[i];
        viewHolder.textTitle.setText(user.getLogin());
        viewHolder.textDeskripsi.setText(user.getAvatarUrl());
    }

    @Override
    public int getItemCount() {
        return list.length;
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        TextView textTitle;
        TextView textDeskripsi;
        public ViewHolder(View itemView) {
            super(itemView);
            textTitle= itemView.findViewById(R.id.text_judul);
            textDeskripsi= itemView.findViewById(R.id.text_deskripsi);
        }
    }
}
