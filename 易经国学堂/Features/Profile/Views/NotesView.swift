//
//  NotesView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

/// 学习笔记列表视图
struct NotesView: View {
    @EnvironmentObject var storageService: StorageService
    @EnvironmentObject var dataService: DataService
    
    @State private var showingAddNote = false
    @State private var selectedHexagramId: Int?
    @State private var searchText = ""
    
    var filteredNotes: [StudyNote] {
        if searchText.isEmpty {
            return storageService.studyNotes
        } else {
            return storageService.studyNotes.filter { note in
                if let hexagram = dataService.getHexagram(by: note.hexagramId) {
                    return hexagram.name.contains(searchText) ||
                           hexagram.chineseName.contains(searchText) ||
                           note.content.contains(searchText)
                }
                return note.content.contains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(hex: "F5F7F9").ignoresSafeArea()

            if storageService.studyNotes.isEmpty {
                emptyView
            } else {
                notesList
            }
        }
        .navigationTitle("学习笔记")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "搜索笔记")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddNote = true }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: "086B52"))
                }
            }
        }
        .sheet(isPresented: $showingAddNote) {
            NoteEditorView(hexagramId: selectedHexagramId)
        }
    }

    // MARK: - 空状态
    private var emptyView: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(hex: "086B52").opacity(0.08))
                    .frame(width: 88, height: 88)
                Image(systemName: "note.text")
                    .font(.system(size: 36))
                    .foregroundColor(Color(hex: "086B52").opacity(0.4))
            }

            Text("还没有学习笔记")
                .font(AppConstants.Fonts.bold(16))
                .foregroundColor(Color(hex: "0F1729"))

            Text("点击右上角 + 号开始记录")
                .font(AppConstants.Fonts.regular(13))
                .foregroundColor(Color(hex: "94A3B8"))

            Button(action: { showingAddNote = true }) {
                Text("创建第一条笔记")
                    .font(AppConstants.Fonts.bold(15))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 13)
                    .background(Color(hex: "086B52"))
                    .cornerRadius(24)
            }
            .padding(.top, 6)
        }
    }

    // MARK: - 笔记列表
    private var notesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(filteredNotes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        NoteRowView(note: note)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(16)
        }
    }
    
    // MARK: - Helper Methods
    private func deleteNotes(at offsets: IndexSet) {
        offsets.forEach { index in
            let note = filteredNotes[index]
            storageService.deleteNote(note)
        }
    }
}

// MARK: - 笔记行
struct NoteRowView: View {
    @EnvironmentObject var dataService: DataService
    let note: StudyNote

    var hexagram: Hexagram? {
        dataService.getHexagram(by: note.hexagramId)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 卦象标题
            if let hexagram = hexagram {
                HStack(spacing: 8) {
                    Text(hexagram.symbol)
                        .font(.system(size: 20))
                    Text(hexagram.chineseName)
                        .font(AppConstants.Fonts.bold(15))
                        .foregroundColor(Color(hex: "0F1729"))
                    Spacer()
                    if note.createdAt != note.updatedAt {
                        Text("已编辑")
                            .font(AppConstants.Fonts.regular(11))
                            .foregroundColor(Color(hex: "086B52").opacity(0.7))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Color(hex: "086B52").opacity(0.08))
                            .cornerRadius(6)
                    }
                }
            }

            // 笔记内容预览
            Text(note.content)
                .font(AppConstants.Fonts.regular(14))
                .foregroundColor(Color(hex: "64748B"))
                .lineLimit(2)
                .lineSpacing(4)

            // 时间
            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .font(.system(size: 11))
                Text(note.updatedAt.relativeDescription)
                    .font(AppConstants.Fonts.regular(12))
                Spacer()
            }
            .foregroundColor(Color(hex: "94A3B8"))
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
    }
}

// MARK: - Note Detail View
struct NoteDetailView: View {
    @EnvironmentObject var storageService: StorageService
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    let note: StudyNote
    @State private var showingEditView = false
    @State private var showingDeleteAlert = false
    
    var hexagram: Hexagram? {
        dataService.getHexagram(by: note.hexagramId)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                // 卦象信息
                if let hexagram = hexagram {
                    HexagramInfoCard(hexagram: hexagram)
                }

                // 笔记内容
                VStack(alignment: .leading, spacing: 10) {
                    Text("笔记内容")
                        .font(AppConstants.Fonts.bold(13))
                        .foregroundColor(Color(hex: "94A3B8"))
                        .tracking(0.6)

                    Text(note.content)
                        .font(AppConstants.Fonts.regular(15))
                        .foregroundColor(Color(hex: "0F1729"))
                        .lineSpacing(5)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
                }

                // 时间信息
                VStack(alignment: .leading, spacing: 8) {
                    Text("记录时间")
                        .font(AppConstants.Fonts.bold(13))
                        .foregroundColor(Color(hex: "94A3B8"))
                        .tracking(0.6)

                    VStack(spacing: 0) {
                        timeRow(icon: "calendar", label: "创建时间", value: note.createdAt.chineseDateString, showDivider: note.createdAt != note.updatedAt)
                        if note.createdAt != note.updatedAt {
                            timeRow(icon: "pencil.circle", label: "更新时间", value: note.updatedAt.chineseDateString, showDivider: false)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
                }
            }
            .padding(16)
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("笔记详情")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: { showingEditView = true }) {
                        Label("编辑", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive, action: { showingDeleteAlert = true }) {
                        Label("删除", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            NoteEditorView(note: note)
        }
        .alert("删除笔记", isPresented: $showingDeleteAlert) {
            Button("取消", role: .cancel) {}
            Button("删除", role: .destructive) {
                storageService.deleteNote(note)
                dismiss()
            }
        } message: {
            Text("确定要删除这条笔记吗？此操作无法撤销。")
        }
    }

    private func timeRow(icon: String, label: String, value: String, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "086B52"))
                Text(label)
                    .font(AppConstants.Fonts.regular(14))
                    .foregroundColor(Color(hex: "64748B"))
                Spacer()
                Text(value)
                    .font(AppConstants.Fonts.regular(13))
                    .foregroundColor(Color(hex: "94A3B8"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            if showDivider { Divider().padding(.horizontal, 16) }
        }
    }
}

// MARK: - 卦象信息卡片
struct HexagramInfoCard: View {
    let hexagram: Hexagram

    var body: some View {
        HStack(spacing: 14) {
            Text(hexagram.symbol)
                .font(.system(size: 44))

            VStack(alignment: .leading, spacing: 4) {
                Text(hexagram.chineseName)
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(Color(hex: "0F1729"))
                Text(hexagram.trigramDescription)
                    .font(AppConstants.Fonts.regular(13))
                    .foregroundColor(Color(hex: "64748B"))
            }

            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
    }
}

// MARK: - Note Editor View
struct NoteEditorView: View {
    @EnvironmentObject var storageService: StorageService
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    let note: StudyNote?
    let hexagramId: Int?
    
    @State private var selectedHexagramId: Int
    @State private var content: String
    @State private var showingHexagramPicker = false
    
    init(note: StudyNote? = nil, hexagramId: Int? = nil) {
        self.note = note
        self.hexagramId = hexagramId
        
        _selectedHexagramId = State(initialValue: note?.hexagramId ?? hexagramId ?? 1)
        _content = State(initialValue: note?.content ?? "")
    }
    
    var selectedHexagram: Hexagram? {
        dataService.getHexagram(by: selectedHexagramId)
    }
    
    var isValid: Bool {
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // ── 选择卦象 ──────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        Text("卦象")
                            .font(AppConstants.Fonts.bold(13))
                            .foregroundColor(Color(hex: "94A3B8"))
                            .tracking(0.6)

                        Button(action: { showingHexagramPicker = true }) {
                            HStack(spacing: 12) {
                                if let hexagram = selectedHexagram {
                                    Text(hexagram.symbol)
                                        .font(.system(size: 24))
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(hexagram.chineseName)
                                            .font(AppConstants.Fonts.bold(16))
                                            .foregroundColor(Color(hex: "0F1729"))
                                        Text(hexagram.trigramDescription)
                                            .font(AppConstants.Fonts.regular(12))
                                            .foregroundColor(Color(hex: "64748B"))
                                    }
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color(hex: "086B52"))
                            }
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(14)
                            .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    // ── 笔记内容 ──────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 8) {
                        Text("笔记内容")
                            .font(AppConstants.Fonts.bold(13))
                            .foregroundColor(Color(hex: "94A3B8"))
                            .tracking(0.6)

                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)

                            if content.isEmpty {
                                Text("在此记录你的学习心得…")
                                    .font(AppConstants.Fonts.regular(15))
                                    .foregroundColor(Color(hex: "C4CEDD"))
                                    .padding(.horizontal, 18)
                                    .padding(.top, 18)
                            }

                            TextEditor(text: $content)
                                .font(AppConstants.Fonts.regular(15))
                                .foregroundColor(Color(hex: "0F1729"))
                                .frame(minHeight: 220)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                        }
                        .frame(minHeight: 220)
                    }

                    // ── 时间信息（编辑模式） ────────────────────────────────
                    if let note = note {
                        VStack(spacing: 0) {
                            noteTimeRow(icon: "calendar", label: "创建时间",
                                        value: note.createdAt.chineseDateString, showDivider: true)
                            noteTimeRow(icon: "pencil.circle", label: "更新时间",
                                        value: note.updatedAt.chineseDateString, showDivider: false)
                        }
                        .background(Color.white)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
                    }

                    Spacer(minLength: 40)
                }
                .padding(16)
            }
            .background(Color(hex: "F5F7F9").ignoresSafeArea())
            .navigationTitle(note == nil ? "新建笔记" : "编辑笔记")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") { dismiss() }
                        .font(AppConstants.Fonts.regular(16))
                        .foregroundColor(Color(hex: "086B52"))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") { saveNote() }
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(isValid ? Color(hex: "086B52") : Color(hex: "C4CEDD"))
                        .disabled(!isValid)
                }
            }
            .sheet(isPresented: $showingHexagramPicker) {
                HexagramPickerView(selectedHexagramId: $selectedHexagramId)
            }
        }
    }

    private func noteTimeRow(icon: String, label: String, value: String, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "086B52"))
                Text(label)
                    .font(AppConstants.Fonts.regular(14))
                    .foregroundColor(Color(hex: "64748B"))
                Spacer()
                Text(value)
                    .font(AppConstants.Fonts.regular(13))
                    .foregroundColor(Color(hex: "94A3B8"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            if showDivider { Divider().padding(.horizontal, 16) }
        }
    }
    
    private func saveNote() {
        if let existingNote = note {
            // 更新现有笔记 - 创建新的StudyNote对象
            let updatedNote = StudyNote(
                id: existingNote.id,
                hexagramId: selectedHexagramId,
                content: content,
                createdAt: existingNote.createdAt,
                updatedAt: Date()
            )
            storageService.updateNote(updatedNote)
        } else {
            // 创建新笔记
            let newNote = StudyNote(
                hexagramId: selectedHexagramId,
                content: content
            )
            storageService.addNote(newNote)
        }
        
        dismiss()
    }
}

// MARK: - Hexagram Picker View
struct HexagramPickerView: View {
    @EnvironmentObject var dataService: DataService
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedHexagramId: Int
    @State private var searchText = ""
    
    var filteredHexagrams: [Hexagram] {
        if searchText.isEmpty {
            return dataService.hexagrams
        } else {
            return dataService.searchHexagrams(query: searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredHexagrams) { hexagram in
                Button(action: {
                    selectedHexagramId = hexagram.id
                    dismiss()
                }) {
                    HStack {
                        Text(hexagram.symbol)
                            .font(.title3)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(hexagram.chineseName)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(hexagram.trigramDescription)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if hexagram.id == selectedHexagramId {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(hex: "086B52"))
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "搜索卦象")
            .navigationTitle("选择卦象")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("取消") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NotesView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

