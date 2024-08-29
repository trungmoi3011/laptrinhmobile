/*
//màn hình đăng nhập
import React, { useState } from 'react';
import { StyleSheet, Text, View, TextInput, Button, Alert, TouchableOpacity, ImageBackground, Image } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons'; // Import thư viện icon

export default function App() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = () => {
    if (email === 'admin@example.com' && password === 'password') {
      Alert.alert('Login Successful', 'Welcome!');
    } else {
      Alert.alert('Login Failed', 'Invalid email or password.');
    }
  };

  const handleForgotPassword = () => {
    Alert.alert('Forgot Password', 'Password recovery options will be sent to your email.');
  };

  const handleHelp = () => {
    Alert.alert('Help', 'Please contact support for assistance.');
  };

  return (
    <ImageBackground 
      source={{ uri: 'https://source.unsplash.com/random/800x600' }} 
      style={styles.background}
    >
      <View style={styles.container}>
        <Image 
          source={{ uri: 'data:image/png;base64,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' }} 
          style={styles.logo} 
        />
        <View style={styles.loginBox}>
          <Text style={styles.title}>Đăng Nhập</Text>
          <TextInput
            style={styles.input}
            placeholder="Email"
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
            placeholderTextColor="#888"
          />
          <TextInput
            style={styles.input}
            placeholder="Mật khẩu"
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            placeholderTextColor="#888"
          />
          <View style={styles.row}>
            <TouchableOpacity onPress={handleForgotPassword}>
              <Text style={styles.link}>Quên mật khẩu?</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={handleHelp} style={styles.helpContainer}>
              <Icon name="help-outline" size={20} color="#007BFF" />
              <Text style={styles.link}>Trợ giúp!</Text>
            </TouchableOpacity>
          </View>
          <Button title="Đăng nhập" onPress={handleLogin} color="#007BFF" />
        </View>
      </View>
    </ImageBackground>
  );
}

const styles = StyleSheet.create({
  background: {
    flex: 1,
    resizeMode: 'cover',
    justifyContent: 'center',
  },
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  logo: {
    width: 250,
    height: 100,
    marginBottom: 20,
    resizeMode: 'contain',
    shadowColor: '#000',
    shadowOpacity: 0.5,
    shadowOffset: { width: 0, height: 4 },
    shadowRadius: 8,
    elevation: 6,
  },
  loginBox: {
    width: '100%',
    maxWidth: 360,
    padding: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.9)', // Nền hộp đăng nhập với độ trong suốt nhẹ
    borderRadius: 15,
    shadowColor: '#000',
    shadowOpacity: 0.3,
    shadowOffset: { width: 0, height: 4 },
    shadowRadius: 10,
    elevation: 6,
  },
  title: {
    fontSize: 26,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 20,
    textAlign: 'center',
  },
  input: {
    width: '100%',
    height: 50,
    borderColor: '#ddd',
    borderWidth: 1,
    marginBottom: 15,
    paddingHorizontal: 15,
    borderRadius: 10,
    backgroundColor: '#fff',
    shadowColor: '#000',
    shadowOpacity: 0.2,
    shadowOffset: { width: 0, height: 2 },
    shadowRadius: 4,
    elevation: 2,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  link: {
    color: '#007BFF',
    fontSize: 14,
  },
  helpContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
});
*/

// màn hìn danh sách sinh viên

/*
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, TextInput, FlatList } from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons'; // Import thư viện icon

const data = [
  { id: 1, code: 'BIT220002', lastName: 'Nguyễn Thành', firstName: 'An' },
  { id: 2, code: 'BIT220007', lastName: 'Nguyễn Trí Hải', firstName: 'An' },
  { id: 3, code: 'BIT220014', lastName: 'Đỗ Lê Việt', firstName: 'Anh' },
  { id: 4, code: 'BIT220019', lastName: 'Hoàng Hải Duy', firstName: 'Anh' },
  { id: 5, code: 'BIT220021', lastName: 'Hà Xuân', firstName: 'Bách' },
  { id: 6, code: 'BIT220189', lastName: 'Nguyễn Ngọc Anh', firstName: 'Dũng' },
  { id: 7, code: 'BIT220037', lastName: 'Vũ Quang', firstName: 'Dũng' },
  { id: 8, code: 'BIT220043', lastName: 'Nguyễn Văn', firstName: 'Dưỡng' },
  { id: 9, code: 'BIT220262', lastName: 'Nguyễn Tiến', firstName: 'Đạt' },
  { id: 10, code: 'BIT220198', lastName: 'Vũ Minh', firstName: 'Đăng' },
  { id: 11, code: 'BIT220029', lastName: 'Lê Thành', firstName: 'Đô̂' },
  { id: 12, code: 'BIT220034', lastName: 'Phạm Đình', firstName: 'Đức' },
  { id: 13, code: 'BIT220204', lastName: 'Trần Trung', firstName: 'Đức' },
  { id: 14, code: 'BIT220048', lastName: 'Nguyễn Thị', firstName: 'Hải' },
  { id: 15, code: 'BIT220051', lastName: 'Nguyễn Thị Mỹ', firstName: 'Hảo' },
  { id: 16, code: 'BIT220060', lastName: 'Lê Minh', firstName: 'Hiếu' },
  { id: 17, code: 'BIT220056', lastName: 'Nguyễn Minh', firstName: 'Hiếu' },
  { id: 18, code: 'BIT220080', lastName: 'Ngô Quang', firstName: 'Huy' },
  { id: 19, code: 'BIT220077', lastName: 'Nguyễn Quang', firstName: 'Huy' },
  { id: 20, code: 'BIT220071', lastName: 'Đoàn Nguyễn Thành', firstName: 'Hưng' },
  { id: 21, code: 'BIT220086', lastName: 'Trần Tuấn', firstName: 'Khoa' },
  { id: 22, code: 'BIT220095', lastName: 'Nguyễn Diệu', firstName: 'Linh' },
  { id: 23, code: 'BIT220100', lastName: 'Nguyễn Minh', firstName: 'Long' },
  { id: 24, code: 'BIT220106', lastName: 'Lê Anh', firstName: 'Minh' },
  { id: 25, code: 'BIT220111', lastName: 'Nguyễn Trà', firstName: 'My' },
  { id: 26, code: 'BIT220123', lastName: 'Trần Phúc', firstName: 'Nguyên' },
  { id: 27, code: 'BIT220126', lastName: 'Lưu Minh', firstName: 'Nhật' },
  { id: 28, code: 'BIT220130', lastName: 'Trần Văn', firstName: 'Phúc' },
  { id: 29, code: 'BIT220264', lastName: 'Phùng Thế', firstName: 'Tài' },
  { id: 30, code: 'BIT220137', lastName: 'Trần Việt', firstName: 'Tài' },
];

export default function App() {
  const renderItem = ({ item }) => (
    <View style={styles.row}>
      <Text style={styles.cellSmall}>{item.id}</Text>
      <Text style={styles.cell}>{item.code}</Text>
      <Text style={styles.cell}>{item.lastName}</Text>
      <Text style={styles.cell}>{item.firstName}</Text>
    </View>
  );

  return (
    <View style={styles.container}>
      <View style={styles.headerContainer}>
        <Text style={styles.header}>Học phần:</Text>
        <TouchableOpacity style={styles.closeButton}>
          <Icon name="close" size={24} color="#000" />
        </TouchableOpacity>
        <View style={styles.subHeaderContainer}>
          <Text style={styles.subHeader}>13:00 - 15:30 (Tiết 7 - 9)</Text>
          <Text style={styles.classInfo}>Lớp</Text>
        </View>
      </View>
      <TouchableOpacity style={styles.saveButton}>
        <Icon name="attach-file" size={20} color="#fff" />
        <Text style={styles.saveButtonText}>Lưu</Text>
      </TouchableOpacity>
      <View style={styles.keywordsContainer}>
        <TextInput
          style={styles.keywordsInput}
          placeholder="Nhập từ khóa điểm danh"
          placeholderTextColor="#555" // Màu chữ placeholder
        />
        <Text style={styles.keywordsLabel}>Từ khóa điểm danh</Text>
      </View>
      <View style={styles.tableContainer}>
        <View style={styles.tableHeader}>
          <Text style={styles.headerCell}>STT</Text>
          <Text style={styles.headerCell}>Mã số</Text>
          <Text style={styles.headerCell}>Họ đệm</Text>
          <Text style={styles.headerCell}>Tên</Text>
        </View>
        <FlatList
          data={data}
          renderItem={renderItem}
          keyExtractor={(item) => item.id.toString()}
        />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  headerContainer: {
    width: '100%',
    position: 'relative',
    flexDirection: 'row', // Sắp xếp các phần tử theo hàng ngang
    alignItems: 'flex-start', // Căn chỉnh theo trục dọc
    justifyContent: 'space-between', // Căn chỉnh khoảng cách giữa các phần tử
  },
  header: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#000',
  },
  subHeaderContainer: {
    flexDirection: 'column', // Sắp xếp các phần tử theo hàng dọc
    alignItems: 'flex-start', // Căn chỉnh các phần tử con về phía bên trái
    position: 'absolute',
    right: 40, // Khoảng cách từ góc phải để thẳng hàng với "Học phần"
    top: 30, // Đặt xuống dưới dòng chữ "Học phần:"
  },
  subHeader: {
    fontSize: 16,
    color: '#555', // Màu đen nhạt hơn
  },
  classInfo: {
    fontSize: 16,
    color: '#555', // Màu đen nhạt hơn
    marginTop: 5, // Khoảng cách giữa dòng "13:00 - 15:30" và "Lớp"
  },
  closeButton: {
    position: 'absolute',
    right: 0, // Đặt vào góc bên phải
    top: 0, // Căn chỉnh với phần đầu
    padding: 10, // Khoảng cách cho nút bấm
  },
  saveButton: {
    marginTop: 20, // Khoảng cách từ phần trên
    backgroundColor: '#007BFF', // Màu nền của nút
    paddingVertical: 10,
    paddingHorizontal: 20,
    borderRadius: 5,
    flexDirection: 'row', // Sắp xếp icon và text theo hàng ngang
    alignItems: 'center', // Căn chỉnh theo trục dọc
  },
  saveButtonText: {
    color: '#fff', // Màu chữ của nút
    fontSize: 16,
    marginLeft: 10, // Khoảng cách giữa icon và chữ
  },
  keywordsContainer: {
    flexDirection: 'row', // Sắp xếp ô nhập liệu và label theo hàng ngang
    alignItems: 'center', // Căn chỉnh theo trục dọc
    marginTop: 20, // Khoảng cách từ nút "Lưu"
    width: '100%', // Chiếm toàn bộ chiều rộng
  },
  keywordsInput: {
    flex: 1, // Chiếm hết không gian có sẵn
    height: 40,
    borderColor: '#ccc',
    borderWidth: 1,
    borderRadius: 5,
    paddingHorizontal: 10,
    fontSize: 16,
  },
  keywordsLabel: {
    fontSize: 16,
    fontWeight: 'bold', // In đậm chữ
    color: '#000', // Màu chữ giống như màu của "Học phần"
    marginLeft: 10, // Khoảng cách giữa ô nhập liệu và label
  },
  tableContainer: {
    marginTop: 20, // Khoảng cách từ ô nhập liệu
    width: '100%',
  },
  tableHeader: {
    flexDirection: 'row', // Sắp xếp các tiêu đề theo hàng ngang
    backgroundColor: '#e0e0e0', // Màu nền của tiêu đề
    paddingVertical: 10,
    borderRadius: 5,
    marginBottom: 5, // Khoảng cách giữa tiêu đề và các hàng
  },
  headerCell: {
    flex: 1, // Chiếm không gian đều nhau
    textAlign: 'center',
    color: '#000', // Màu chữ của tiêu đề
    fontWeight: 'bold',
  },
  row: {
    flexDirection: 'row', // Sắp xếp các ô theo hàng ngang
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
    paddingVertical: 10,
    alignItems: 'center',
  },
  cell: {
    flex: 1, // Chiếm không gian đều nhau
    textAlign: 'center',
    fontSize: 16,
  },
  cellSmall: {
    flex: 0.5, // Chiếm không gian nhỏ hơn cho cột STT
    textAlign: 'center',
    fontSize: 16,
  },
});
*/

// màn quản lý điểm danh 
import React from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity, ScrollView } from 'react-native';

const data = [
  'BIT220002', 'BIT220007', 'BIT220014', 'BIT220019', 'BIT220021', 
  'BIT220189', 'BIT220037', 'BIT220043', 'BIT220262', 'BIT220198', 
  'BIT220029', 'BIT220034', 'BIT220204', 'BIT220048', 'BIT220051', 
  'BIT220060', 'BIT220056', 'BIT220080', 'BIT220077', 'BIT220071', 
  'BIT220086', 'BIT220095', 'BIT220100', 'BIT220106', 'BIT220111', 
  'BIT220123', 'BIT220126', 'BIT220130', 'BIT220264', 'BIT220137'
];

export default function App() {
  return (
    <View style={styles.container}>
      {/* Dòng tiêu đề học phần */}
      <Text style={styles.title}>Học Phần: Lập trình C#</Text>
      {/* Dòng thời gian và phòng học */}
      <Text style={styles.subtitle}>Thời gian: 07:00 - 09:40 (Phòng học: VPC2-404)</Text>
      
      {/* Bảng điểm danh tự động */}
      <View style={styles.tableContainer}>
        <Text style={styles.tableTitle}>ĐIỂM DANH TỰ ĐỘNG</Text>
        {/* Ô nhập văn bản và nút lưu */}
        <View style={styles.inputContainer}>
          <TextInput
            style={styles.input}
            placeholder="Nhập từ khóa"
            placeholderTextColor="#888" // Màu chữ của placeholder
          />
          <TouchableOpacity style={styles.saveButton}>
            <Text style={styles.buttonText}>Lưu từ khóa</Text>
          </TouchableOpacity>
        </View>
        {/* Nút lưu điểm danh tự động */}
        <TouchableOpacity style={styles.autoSaveButton}>
          <Text style={styles.buttonText}>Lưu điểm danh tự động</Text>
        </TouchableOpacity>
      </View>

      {/* Bảng điểm danh thủ công */}
      <View style={styles.manualTableContainer}>
        <Text style={styles.manualTableTitle}>ĐIỂM DANH THỦ CÔNG</Text>
        {/* Dòng thông tin sĩ số với các ô nhập liệu */}
        <View style={styles.manualTableInfoContainer}>
          <View style={styles.infoColumn}>
            <Text style={styles.infoLabel}>Sĩ số:</Text>
            <TextInput
              style={styles.tableCellInput}
              defaultValue="30"
              keyboardType="numeric"
            />
          </View>
          <View style={styles.infoColumn}>
            <Text style={styles.infoLabel}>Có mặt:</Text>
            <TextInput
              style={styles.tableCellInput}
              defaultValue="30"
              keyboardType="numeric"
            />
          </View>
          <View style={styles.infoColumn}>
            <Text style={styles.infoLabel}>Vắng:</Text>
            <TextInput
              style={styles.tableCellInput}
              defaultValue="0"
              keyboardType="numeric"
            />
          </View>
          <View style={styles.infoColumn}>
            <Text style={styles.infoLabel}>Vắng phép:</Text>
            <TextInput
              style={styles.tableCellInput}
              defaultValue="0"
              keyboardType="numeric"
            />
          </View>
        </View>
        {/* Nút lưu điểm danh thủ công */}
        <TouchableOpacity style={styles.manualSaveButton}>
          <Text style={styles.manualSaveButtonText}>LƯU ĐIỂM DANH THỦ CÔNG</Text>
        </TouchableOpacity>
      </View>

      {/* Bảng thông tin chi tiết */}
      <ScrollView style={styles.detailsTableContainer}>
        <View style={styles.tableHeader}>
          <Text style={styles.tableHeaderText}>Tổng buổi vắng</Text>
          <Text style={styles.tableHeaderText}>Mã số</Text>
          <Text style={styles.tableHeaderText}>Địa chỉ IP</Text>
          <Text style={styles.tableHeaderText}>Vắng</Text>
          <Text style={styles.tableHeaderText}>Vắng phép</Text>
          <Text style={styles.tableHeaderText}>Có mặt</Text>
        </View>
        {data.map((item, index) => (
          <View key={index} style={styles.tableRow}>
            <TextInput
              style={styles.tableCellInput}
              placeholder="0"
              keyboardType="numeric"
            />
            <Text style={styles.tableCell}>{item}</Text>
            <TextInput
              style={styles.tableCellInput}
              placeholder="0"
              keyboardType="numeric"
            />
            <TextInput
              style={styles.tableCellInput}
              placeholder="0"
              keyboardType="numeric"
            />
            <TextInput
              style={styles.tableCellInput}
              placeholder="0"
              keyboardType="numeric"
            />
            <TextInput
              style={styles.tableCellInput}
              placeholder="0"
              keyboardType="numeric"
            />
          </View>
        ))}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#000',
    marginBottom: 10, // Khoảng cách dưới dòng tiêu đề
  },
  subtitle: {
    fontSize: 16,
    color: '#888', // Màu xám nhạt
    marginBottom: 20, // Khoảng cách dưới dòng phụ
  },
  tableContainer: {
    width: '100%',
    backgroundColor: '#0033A0', // Màu nền xanh nước biển đậm
    padding: 15,
    borderRadius: 5,
    marginTop: 20, // Khoảng cách từ dòng phụ đến bảng
  },
  tableTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff', // Màu chữ trắng
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 20,
  },
  input: {
    flex: 1,
    padding: 10,
    backgroundColor: '#fff', // Màu nền của ô nhập văn bản
    borderRadius: 5,
    borderColor: '#ddd',
    borderWidth: 1,
  },
  saveButton: {
    marginLeft: 10,
    padding: 15,
    backgroundColor: '#007BFF', // Màu nền của nút lưu
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
  },
  autoSaveButton: {
    marginTop: 20,
    padding: 10,
    backgroundColor: '#4CAF50', // Màu xanh lá non
    borderRadius: 5,
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonText: {
    color: '#fff', // Màu chữ của nút
    fontWeight: 'bold',
  },
  manualTableContainer: {
    width: '100%',
    backgroundColor: '#FF8C00', // Màu cam đậm
    padding: 15,
    borderRadius: 5,
    marginTop: 20, // Khoảng cách từ bảng điểm danh tự động đến bảng này
  },
  manualTableTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#fff', // Màu chữ trắng
  },
  manualTableInfoContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 10, // Khoảng cách từ tiêu đề đến thông tin sĩ số
  },
  infoColumn: {
    flex: 1,
    alignItems: 'center',
  },
  infoLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#fff',
  },
  tableCellInput: {
    flex: 1,
    padding: 1,
    backgroundColor: '#f5f5f5', // Màu nền của ô nhập liệu
    borderRadius: 30,
    borderColor: '#ddd',
    borderWidth: 10,
    textAlign: 'center',
  },
  manualSaveButton: {
    marginTop: 10,
    padding: 10,
    backgroundColor: '#fff', // Màu nền trắng
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
    borderColor: '#FF8C00', // Màu viền cam đậm
    borderWidth: 1,
  },
  manualSaveButtonText: {
    color: '#FF8C00', // Màu chữ cam đậm
    fontWeight: 'bold',
  },
  detailsTableContainer: {
    width: '100%',
    marginTop: 20, // Khoảng cách từ bảng điểm danh thủ công đến bảng chi tiết
  },
  tableHeader: {
    flexDirection: 'row',
    backgroundColor: '#0033A0', // Màu nền xanh nước biển đậm
    padding: 10,
    borderRadius: 5,
  },
  tableHeaderText: {
    flex: 1,
    color: '#fff', // Màu chữ trắng
    textAlign: 'center',
    fontWeight: 'bold',
  },
  tableRow: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
  },
  tableCell: {
    flex: 1,
    textAlign: 'center',
    padding: 5,
  },
});






