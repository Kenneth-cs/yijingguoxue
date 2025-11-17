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
        NavigationView {
            ZStack {
                if storageService.studyNotes.isEmpty {
                    emptyView
                } else {
                    notesList
                }
            }
            .navigationTitle("学习笔记")
            .searchable(text: $searchText, prompt: "搜索笔记")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddNote = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                NoteEditorView(hexagramId: selectedHexagramId)
            }
        }
    }
    
    // MARK: - Empty View
    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("还没有学习笔记")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("点击右上角 + 号开始记录")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: { showingAddNote = true }) {
                Text("创建第一条笔记")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(AppConstants.UI.cornerRadius)
            }
            .padding(.top, 10)
        }
        .padding()
    }
    
    // MARK: - Notes List
    private var notesList: some View {
        List {
            ForEach(filteredNotes) { note in
                NavigationLink(destination: NoteDetailView(note: note)) {
                    NoteRowView(note: note)
                }
            }
            .onDelete(perform: deleteNotes)
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

// MARK: - Note Row View
struct NoteRowView: View {
    @EnvironmentObject var dataService: DataService
    let note: StudyNote
    
    var hexagram: Hexagram? {
        dataService.getHexagram(by: note.hexagramId)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 卦象标题
            if let hexagram = hexagram {
                HStack {
                    Text(hexagram.symbol)
                        .font(.title3)
                    
                    Text(hexagram.chineseName)
                        .font(.headline)
                    
                    Spacer()
                }
            }
            
            // 笔记内容预览
            Text(note.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            // 时间信息
            HStack {
                Image(systemName: "clock")
                    .font(.caption)
                
                Text(note.updatedAt.relativeDescription)
                    .font(.caption)
                
                Spacer()
                
                if note.createdAt != note.updatedAt {
                    Text("已编辑")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }
            }
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 卦象信息
                if let hexagram = hexagram {
                    HexagramInfoCard(hexagram: hexagram)
                }
                
                // 笔记内容
                VStack(alignment: .leading, spacing: 10) {
                    Text("笔记内容")
                        .font(.headline)
                    
                    Text(note.content)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground))
                        .cornerRadius(AppConstants.UI.cornerRadius)
                }
                
                // 时间信息
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("创建时间：")
                        Text(note.createdAt.chineseDateString)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    
                    if note.createdAt != note.updatedAt {
                        HStack {
                            Image(systemName: "pencil.circle")
                            Text("更新时间：")
                            Text(note.updatedAt.chineseDateString)
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(AppConstants.UI.cornerRadius)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
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
}

// MARK: - Hexagram Info Card
struct HexagramInfoCard: View {
    let hexagram: Hexagram
    
    var body: some View {
        HStack(spacing: 15) {
            Text(hexagram.symbol)
                .font(.system(size: 50))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(hexagram.chineseName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(hexagram.trigramDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
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
            Form {
                Section("卦象") {
                    Button(action: { showingHexagramPicker = true }) {
                        HStack {
                            if let hexagram = selectedHexagram {
                                Text(hexagram.symbol)
                                    .font(.title3)
                                
                                Text(hexagram.chineseName)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Section("笔记内容") {
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
                
                if let note = note {
                    Section("时间信息") {
                        LabeledContent("创建时间", value: note.createdAt.chineseDateString)
                        LabeledContent("更新时间", value: note.updatedAt.chineseDateString)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
            .navigationTitle(note == nil ? "新建笔记" : "编辑笔记")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        saveNote()
                    }
                    .disabled(!isValid)
                }
            }
            .sheet(isPresented: $showingHexagramPicker) {
                HexagramPickerView(selectedHexagramId: $selectedHexagramId)
            }
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
                                .foregroundColor(.blue)
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

