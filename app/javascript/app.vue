<template>
  <div>
    <h2>ssc by EGGTART😈</h2>
    <h1>🍉upload</h1>
    <div style="width: 100%; text-align: center;">
      <el-upload
              drag
              multiple
              action="/upload/"
              :on-preview="handlePreview"
              :on-remove="handleRemove"
              :on-success="handleSuccess"
              :on-progress="handleProgress"
              :file-list="fileList">
        <br/>
        <span style="font-size: 70px;">🍭</span>
        <div class="el-upload__text">拖入 or <em>click to upload \^O^/</em></div>
      </el-upload>
    </div>

    <h1>🍒download</h1>
    <el-table :data="fileInfo.filter(row => row.name.toLowerCase().includes(search.toLowerCase()))"
              :default-sort="{prop: 'mtime', order: 'descending'}"
              v-loading="loading"
              element-loading-text="Now Loading..."
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(0, 0, 0, 0.8)">
      <el-table-column prop="mtime" width="195px" label="最后修改">
        <span slot-scope="scope">
          {{scope.row.mtime.substr(0, scope.row.mtime.length - 6)}}
        </span>
      </el-table-column>
      <el-table-column prop="name" label="文件名">
        <span slot-scope="scope">
          <span style="font-weight: bold; font-size: 14px;">{{scope.row.name}}</span>
        </span>
      </el-table-column>
      <el-table-column prop="size" label="大小">
        <span slot-scope="scope">
          {{sizeDesc(parseFloat(scope.row.size))}}
        </span>
      </el-table-column>
      <el-table-column prop="count" label="下载次数"/>
      <el-table-column width="200px" fixed="right">
        <span slot="header" slot-scope="scope">
          <el-input placeholder="模糊搜索" v-model="search"/>
        </span>
        <span slot-scope="scope">
          <el-button type="primary" size="medium" @click="handleDownload(scope.row.name)">Pick!</el-button>
          <el-button type="danger" size="medium" @click="handleDelete(scope.row.name)">Delete!</el-button>
        </span>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        fileList: [],
        fileInfo: [],
        search: '',
        loading: false
      };
    },
    created() {
      this.init(true);
    },
    methods: {
      init(makeLoading) {
        this.loading = !makeLoading;
        axios.get('/upload/list').then(res => {
          this.fileInfo = res.data;
        }).finally(() => {
          this.loading = false;
        });
      },
      handleDownload(filename) {
        window.location.href = '/upload/pick?filename=' + filename;
        window.setTimeout(() => {
          this.init(false);
        }, 200);
      },
      handleDelete(filename) {
        this.$confirm('确认要删除' + filename + '吗？', 'ssc', {
          confirmButtonText: '删除',
          cancelButtonText: '取消'
        }).then(() => {
          axios.get('/upload/delete?filename=' + filename).finally(res => {
            this.$notify({ type: 'success', message: '已删除' + filename });
          });
        }).catch(() => {
          // :)
        }).finally(() => {
          this.init(false);
        });
      },
      sizeDesc(size) {
        if (size < 1024)
          return size + ' 字节';
        let levels = ['KB', 'MB', 'GB', 'TB', 'PB'];
        for (let i = 0; i < levels.length; i++) {
          let base = Math.pow(1024.0, 1 + i);
          if (size / base < base)
            return (size / base).toFixed(2) + ' ' + levels[i];
        }
        return 'ん？';
      },
      handlePreview(file) {

      },
      handleRemove(file, fileList) {

      },
      // response, file, fileList
      handleSuccess() {
        this.init(false);
      },
      handleProgress(event, file, fileList) {

      }
    }
  };
</script>
